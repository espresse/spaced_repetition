require "spaced_repetition"
require "test/unit"
 
class TestSm2 < Test::Unit::TestCase

  def test_scenario_user_starts_learning_new_element
    sm2 = SpacedRepetition::Sm2.new(5)
    assert_equal(1, sm2.interval)
    assert_in_delta 2.6, sm2.easiness_factor, 0.001

    sm2 = SpacedRepetition::Sm2.new(4)
    assert_equal(1, sm2.interval)
    assert_in_delta 2.5, sm2.easiness_factor, 0.001

    sm2 = SpacedRepetition::Sm2.new(3)
    assert_equal(1, sm2.interval)
    assert_in_delta 2.36, sm2.easiness_factor, 0.001
  end

  def test_scenario_user_is_doing_good
    sm2 = SpacedRepetition::Sm2.new(4, 6, 2.1)
    assert_equal(12, sm2.interval)
    assert_in_delta 2.1, sm2.easiness_factor, 0.001

    sm2 = SpacedRepetition::Sm2.new(5, 12, 2.1)
    assert_equal(25, sm2.interval)
    assert_in_delta 2.2, sm2.easiness_factor, 0.001

    sm2 = SpacedRepetition::Sm2.new(5, 25, 2.1)
    assert_equal(52, sm2.interval)
    assert_in_delta 2.2, sm2.easiness_factor, 0.001
  end

  def test_scenario_user_is_doing_good_but_later_is_going_bad
    sm2 = SpacedRepetition::Sm2.new(3, 6, 2.1)
    assert_equal(12, sm2.interval)
    assert_in_delta 1.96, sm2.easiness_factor, 0.001

    sm2 = SpacedRepetition::Sm2.new(0, 12, 1.96)
    assert_equal(1, sm2.interval)
    assert_in_delta 1.96, sm2.easiness_factor, 0.001

    sm2 = SpacedRepetition::Sm2.new(0, 1, 1.96)
    assert_equal(1, sm2.interval)
    assert_in_delta 1.96, sm2.easiness_factor, 0.001
  end

  def test_scenario_user_passed_char_instead_of_number
    assert_raise( ArgumentError ) { SpacedRepetition::Sm2.new("a", 6, 2.1) }
  end

  
end

