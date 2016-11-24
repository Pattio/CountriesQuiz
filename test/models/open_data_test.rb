require 'test_helper'

class OpenDataTest < ActiveSupport::TestCase

  test "create valid open data" do
    data = OpenData.new(
        Description: "My Event",
        Unit: "It's really good",
        Value: "tomorrow")
    assert data.valid?
  end
end
