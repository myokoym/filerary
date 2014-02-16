require "filerary"
require "fileutils"

class FileraryTest < Test::Unit::TestCase
  def setup
    @test_base_dir = File.join(File.dirname(__FILE__), "tmp")
    FileUtils.mkdir_p(@test_base_dir)
    @librarian = Filerary::Librarian.new(@test_base_dir)
  end

  def teardown
    FileUtils.rm_rf(@test_base_dir)
  end

  def test_default_db_dir
    home_dir = File.expand_path("~")
    librarian = Filerary::Librarian.new
    default_db_dir = File.join(home_dir, ".filerary", "db")
    assert_equal(default_db_dir, librarian.db_dir)
  end

  class CollectTest < self
    def test_string
      assert_equal([__FILE__], @librarian.collect(__FILE__))
    end

    def test_array
      assert_equal([__FILE__], @librarian.collect([__FILE__]))
    end
  end

  class SearchTest < self
    def setup
      super
      @librarian.collect(__FILE__)
    end

    def test_found
      assert_equal([__FILE__], @librarian.search("Librarian"))
    end

    def test_not_found
      assert_equal([], @librarian.search("AAA" * 5))
    end
  end

  class CleanupTest < self
    def setup
      super
      @temp_file = File.join(@test_base_dir, "cleanup.txt")
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
