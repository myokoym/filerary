require "filerary"

class FileraryTest < Test::Unit::TestCase
  def setup
    @filerary = Filerary::Librarian.new
  end

  def test_default_db_dir
    home_dir = File.expand_path("~")
    default_db_dir = File.join(home_dir, ".filerary", "db")
    assert_equal(default_db_dir, @filerary.db_dir)
  end

  def test_collect
    assert_true(@filerary.respond_to?(:collect))
  end

  def test_search
    assert_true(@filerary.respond_to?(:search))
  end
end
