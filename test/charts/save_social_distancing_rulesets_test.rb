require 'test_helper'
require 'util'

class SaveSocialDistancingRulesetsTest < SeatsioTestClient

  def test_save_social_distancing_rulesets
    chart = @seatsio.charts.create
    rulesets = {
        "ruleset1" => {
                "name" => "My first ruleset",
                "numberOfDisabledSeatsToTheSides" => 1,
                "disableSeatsInFrontAndBehind" => true,
                "numberOfDisabledAisleSeats" => 2,
                "maxGroupSize" => 1,
                "disabledSeats" => ["A-1"],
                "enabledSeats" => ["A-2"],
                "index" => 4,
            },
        "ruleset2" => {
                "name" => "My second ruleset"
            }
    }

    @seatsio.charts.save_social_distancing_rulesets(chart.key, rulesets)

    retrieved_chart = @seatsio.charts.retrieve(chart.key)
    epected_rulesets = {
        "ruleset1" => Seatsio::Domain::SocialDistancingRuleset.new("My first ruleset", 1, true, 2, 1, ["A-1"], ["A-2"], 4),
        "ruleset2" => Seatsio::Domain::SocialDistancingRuleset.new("My second ruleset")
    }
    assert_equal(epected_rulesets, retrieved_chart.social_distancing_rulesets)
  end

end