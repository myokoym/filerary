require "filerarian"

class FilerarianTest < Test::Unit::TestCase
  def setup
    @filerarian = Filerarian::Obj.new
  end

  def test_collect
    assert_true(@filerarian.respond_to?(:collect))
  end

  def test_search
    assert_true(@filerarian.respond_to?(:search))
  end
end
