# == Schema Information
#
# Table name: team_games
#
#  id         :integer          not null, primary key
#  game_id    :integer
#  team_id    :integer
#  score      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class TeamGameTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
