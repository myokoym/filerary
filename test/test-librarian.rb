require "filerary"
require "fileutils"

class FileraryTest < Test::Unit::TestCase
  def setup
    @test_base_dir = File.join(File.dirname(__FILE__), "tmp")
    FileUtils.mkdir_p(@test_base_dir)
    @librarian = Filerary::Librarian.new(@test_base_dir)
  end

  def teardown
    Dir.glob("#{@test_base_dir}/*.db*") do |path|
      FileUtils.rm(path)
    end
    FileUtils.rmdir(@test_base_dir)
  end

  def test_default_db_dir
    home_dir = File.expand_path("~")
    librarian = Filerary::Librarian.new
    default_db_dir = File.join(home_dir, ".filerary", "db")
    assert_equal(default_db_dir, librarian.db_dir)
  end

  class CollectTest
    def test_collect
      assert_equal([__FILE__], @librarian.collect(__FILE__))
    end
  end

  class SearchTest
    def test_search
      @librarian.collect(__FILE__)
      assert_equal([__FILE__], @librarian.search("Librarian"))
    end
  end
end
