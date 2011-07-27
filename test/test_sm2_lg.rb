require "spaced_repetition"
require "test/unit"
include SpacedRepetition

class TestSm2Lg < Test::Unit::TestCase

  def test_scenario_user_starts_learning_new_element
    sm2 = Sm2Lg.new(3)
    assert((7..9).include?(sm2.interval))
    assert_in_delta 2.6, sm2.easiness_factor, 0.001

    sm2 = Sm2Lg.new(2)
    assert((3..5).include?(sm2.interval))
    assert_in_delta 2.5, sm2.easiness_factor, 0.001

    sm2 = Sm2Lg.new(1)
    assert_equal(1, sm2.interval)
    assert_in_delta 2.2, sm2.easiness_factor, 0.001

    sm2 = Sm2Lg.new(0)
    assert_equal(0, sm2.interval)
    assert_in_delta 1.7, sm2.easiness_factor, 0.001
  end

  def test_scenario_user_is_doing_good
    sm2 = Sm2Lg.new(3, 9, 2.6, Date.today)
    assert_equal(23, sm2.interval)

    sm2 = Sm2Lg.new(3, 9, 2.6, Date.today-60)
    assert_equal(83, sm2.interval)
  end

  def test_scenario_user_is_doing_ok
    sm2 = Sm2Lg.new(2, 5, 2.5, Date.today)
    assert_equal(12, sm2.interval)

    sm2 = Sm2Lg.new(2, 5, 2.5, Date.today-60)
    assert_equal(42, sm2.interval)
  end

  def test_scenario_user_is_doing_so_so
    sm2 = Sm2Lg.new(1, 1, 2.2, Date.today)
    assert_equal(2, sm2.interval)

    sm2 = Sm2Lg.new(1, 1, 2.2, Date.today-60)
    assert_equal(22, sm2.interval)
  end

  def test_scenario_user_is_doing_bad
    sm2 = Sm2Lg.new(0, 1, 1.7, Date.today)
    assert_equal(0, sm2.interval)
    assert_in_delta 1.3, sm2.easiness_factor, 0.001

    sm2 = Sm2Lg.new(0, 1, 1.7, Date.today-60)
    assert_equal(0, sm2.interval)
    assert_in_delta 1.3, sm2.easiness_factor, 0.001
  end

end

