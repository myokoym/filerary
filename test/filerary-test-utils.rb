module FileraryTestUtils
  def omit_on_travis_ci
    omit("this test can't be run on Travis CI") if ENV["CI"]
  end
end
