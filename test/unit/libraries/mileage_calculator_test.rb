require 'mileage_calculator.rb'

class MileageCalculatorTest < ActionController::TestCase

  test 'should generate labels in correct order' do
    labels = MileageCalculator.labels 'Febuary'
    expected_results = %w(February March April May June July August September October November December January)
    assert_equal(labels, expected_results)
  end

  test 'should calculate monthly expected mileage' do
    expected = MileageCalculator.expected(10_000, 100, 12)
    expected_results = [933, 1766, 2599, 3432, 4265, 5098, 5931, 6764, 7597, 8430, 9263, 10096]
    assert_equal(expected, expected_results)
  end

  test 'should calculate actual mileage' do
    actual = MileageCalculator.actual(1, 12, '01-09-2014')
    expected_results =  [0, 500.0, 800.0, 1400.0, 1600.0, 0, 0, 2800.0, 0, 0, 0, 0]
    assert_equal(12, actual.length)
    assert_equal(actual, expected_results)
  end


end
