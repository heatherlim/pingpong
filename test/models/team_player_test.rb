# == Schema Information
#
# Table name: team_players
#
#  id         :integer          not null, primary key
#  player_id  :integer
#  team_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class TeamPlayerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
