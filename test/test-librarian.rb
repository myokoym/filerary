require "filerary"

class FileraryTest < Test::Unit::TestCase
  def setup
    @filerary = Filerary::Librarian.new
  end

  def test_collect
    assert_true(@filerary.respond_to?(:collect))
  end

  def test_search
    assert_true(@filerary.respond_to?(:search))
  end
end
