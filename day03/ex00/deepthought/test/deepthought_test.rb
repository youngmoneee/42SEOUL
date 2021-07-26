# frozen_string_literal: true

require "test_helper"
require "colorize"

class DeepthoughtTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Deepthought::VERSION
  end

  def test_it_does_something_useful
    tester = Deepthought.new
    assert_equal(tester.respond("hi"), "Mmmm i'm bored")
    assert_equal(tester.respond("The Ultimate Question of Life, the Universe and Everything"), "42")
    
    assert_kind_of(String, tester.respond("The Ultimate Question of Life, the Universe and Everythin"), "Mmmm i'm bored")
    assert_kind_of(String, tester.respond("The Ultimate Question of Life, the Universe and Everything"), "42")

    assert(tester.respond("The Ultimate Question of Life, the Universe and Everythin"), "Mmmm i'm bored")
    assert(tester.respond("The Ultimate Question of Life, the Universe and Everything"), "42")

  end
end
