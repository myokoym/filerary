# -*- coding: utf-8 -*-

require "filerary"
require "fileutils"
require "tmpdir"

class FileraryTest < Test::Unit::TestCase
  include FileraryTestUtils

  def setup
    @test_dir = File.expand_path(File.dirname(__FILE__))
    @test_fixtures_dir = File.join(@test_dir, "fixtures")
    @test_tmp_dir = File.join(@test_dir, "tmp")
    FileUtils.mkdir_p(@test_tmp_dir)
    @librarian = Filerary::Librarian.new(@test_tmp_dir)
  end

  def teardown
    FileUtils.rm_rf(@test_tmp_dir)
  end

  def test_default_db_dir
    home_dir = File.expand_path("~")
    librarian = Filerary::Librarian.new
    default_db_dir = File.join(home_dir, ".filerary", "db")
    assert_equal(default_db_dir, librarian.db_dir)
  end

  sub_test_case("collect") do
    sub_test_case("argument") do
      def test_string
        assert_equal([__FILE__], @librarian.collect(__FILE__))
      end

      def test_array
        assert_equal([__FILE__], @librarian.collect([__FILE__]))
      end
    end

    sub_test_case("file path") do
      def test_multibyte
        Dir.mktmpdir do |tmpdir|
          path = File.join(tmpdir, "マルチバイト.txt")
          FileUtils.touch(path)
          @librarian.collect(path)
          assert_equal(1, @librarian.size)
        end
      end
    end

    sub_test_case("file type") do
      def test_pdf
        path = File.join(@test_fixtures_dir, "test-pdf.pdf")
        @librarian.collect(path)
        assert_equal(1, @librarian.size)
      end

      def test_xls
        path = File.join(@test_fixtures_dir, "test-excel.xls")
        @librarian.collect(path)
        assert_equal(1, @librarian.size)
      end
    end

    sub_test_case("file content") do
      def test_empty
        path = "empty"
        stub(@librarian).read_content(path) { nil }
        @librarian.collect(path)
        assert_equal(0, @librarian.size)
      end
    end
  end

  sub_test_case("search") do
    def test_found
      @librarian.collect(__FILE__)
      assert_equal([__FILE__], @librarian.search("Librarian"))
    end

    def test_not_found
      @librarian.collect(__FILE__)
      assert_equal([], @librarian.search("AAA" * 5))
    end

    class FileTypeTest < self
      def test_pdf
        path = File.join(@test_fixtures_dir, "test-pdf.pdf")
        @librarian.collect(path)
        assert_equal([path], @librarian.search("秋"))
        assert_equal([], @librarian.search("冬"))
      end

      def test_xls
        path = File.join(@test_fixtures_dir, "test-excel.xls")
        @librarian.collect(path)
        assert_equal([path], @librarian.search("Excel"))
      end

      def test_xls_of_multibyte
        # TODO: I want to detective.
        omit_on_travis_ci
        path = File.join(@test_fixtures_dir, "test-excel.xls")
        @librarian.collect(path)
        assert_equal([path], @librarian.search("表計算ソフト"))
        assert_equal([], @librarian.search("文書作成ソフト"))
      end
    end
  end

  sub_test_case("cleanup") do
    sub_test_case("ascii file name") do
      def setup
        super
        @temp_file = File.join(@test_tmp_dir, "cleanup.txt")
        FileUtils.cp(__FILE__, @temp_file)
        @librarian.collect(@temp_file)
      end

      def teardown
        super
        FileUtils.rm_f(@temp_file)
      end

      def test_removed
        FileUtils.rm(@temp_file)
        assert_equal([@temp_file], @librarian.search("Librarian"))
        @librarian.cleanup
        assert_equal([], @librarian.search("Librarian"))
      end

      def test_not_removed
        assert_equal([@temp_file], @librarian.search("Librarian"))
        @librarian.cleanup
        assert_equal([@temp_file], @librarian.search("Librarian"))
      end
    end
  end
end
