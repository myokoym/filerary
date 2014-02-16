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
    def test_collect
      assert_equal([__FILE__], @librarian.collect(__FILE__))
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
end
