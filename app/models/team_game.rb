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

class TeamGame < ActiveRecord::Base
 belongs_to :game
 belongs_to :team
end
