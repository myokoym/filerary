# -*- coding: utf-8 -*-

require "filerary"
require "fileutils"

class FileraryTest < Test::Unit::TestCase
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

  class CollectTest < self
    def test_argument_is_string
      assert_equal([__FILE__], @librarian.collect(__FILE__))
    end

    def test_argument_is_array
      assert_equal([__FILE__], @librarian.collect([__FILE__]))
    end

    def test_flle_type_is_pdf
      path = File.join(@test_fixtures_dir, "test-pdf.pdf")
      assert_equal([path], @librarian.collect(path))
    end
  end

  class SearchTest < self
    def test_found
      @librarian.collect(__FILE__)
      assert_equal([__FILE__], @librarian.search("Librarian"))
    end

    def test_not_found
      @librarian.collect(__FILE__)
      assert_equal([], @librarian.search("AAA" * 5))
    end

    def test_file_type_is_pdf
      path = File.join(@test_fixtures_dir, "test-pdf.pdf")
      @librarian.collect(path)
      assert_equal([path], @librarian.search("秋"))
    end
  end

  class CleanupTest < self
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
