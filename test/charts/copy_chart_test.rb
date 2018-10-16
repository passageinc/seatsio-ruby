require "test_helper"
require "util"

class CopyChartTest < Minitest::Test
  def setup
    @user = create_test_user
    @seatsio = Seatsio::Seatsio.new(@user["secretKey"], "https://api-staging.seatsio.net")
  end

  def test_copy_chart
    chart = @seatsio.client.charts.create("my chart", "BOOTHS")
    copied_chart = @seatsio.client.charts.copy(chart.key)

    assert_equal("my chart (copy)", copied_chart.name)

    drawing = @seatsio.client.charts.retrieve_published_version(copied_chart.key)
    assert_equal("BOOTHS", drawing.venue_type)
    puts "as"

  end
end