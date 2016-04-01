# == Schema Information
#
# Table name: players
#
#  id              :integer          not null, primary key
#  name            :string
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Player < ActiveRecord::Base
  # has_many :team_players
  # has_many :teams, through: :team_players
  belongs_to :course
  has_and_belongs_to_many :teams
  has_many :games, through: :teams
  validates_presence_of :name, :email
  validates_uniqueness_of :email
   has_secure_password

  attr_accessor :remember_token

      def singles_team
        Team.find_or_create_by_player_ids([self.id, 0])
      end

      def future_games

      end

      def historical_games

      end

      def singles_games
        singles_team.games
      end

      def singles_games_total
        singles_games.count
      end

      # def singles_wins
      #   singles_games.select do |game|
      #     game.winning_team == singles_team
      #   end.count
      # end

      # def singles_losses
      #   singles_games.select do |game|
      #     game.losing_team == singles_team
      #   end.count
      # end

      def doubles_teams
        singles_team
        self.teams - [singles_team]
      end

      def doubles_games
        doubles_teams.map do |team|
          team.games
        end.compact.flatten
      end

      def doubles_games_total
        doubles_games.count
      end

      def games_total
        singles_games_total + doubles_games_total
      end


      ### RECORD ###

      def singles_wins
        singles_games.select do |game|
          game.winning_team.players.include?(self)
        end
      end

      def singles_losses
        singles_games.select do |game|
          game.losing_team.players.include?(self)
        end
      end

      def doubles_wins
        doubles_games.select do |game|
          game.winning_team.players.include?(self)
        end
      end

      def doubles_losses
        doubles_games.select do |game|
          game.losing_team.players.include?(self)
        end
      end

      def overall_wins
        singles_wins.count + doubles_wins.count
      end

      def overall_losses
        singles_losses.count + doubles_losses.count
      end


      def singles_win_average
        if singles_games_total != 0
        (singles_wins.count * 1.0) / singles_games_total
        else 
          0
        end
      end

      def doubles_win_average
        if doubles_games_total != 0
          (doubles_wins.count * 1.0) / doubles_games_total
        else
          0
        end
      end

      def overall_win_average
        if games_total != 0
          (overall_wins * 1.0) / games_total
        else
          0
        end
      end


      def self.singles_top_ten
        ascending_array = Player.all.sort_by {| player| player.singles_win_average }
        descending_array = ascending_array.reverse
        descending_array[0..9]
      end

      def self.doubles_top_ten
        ##
        ascending_array = Player.all.sort_by {| player| player.doubles_win_average }
        descending_array = ascending_array.reverse
        descending_array[0..9]
      end

      def self.overall_top_ten
        ascending_array = Player.all.sort_by {| player| player.overall_win_average }
        descending_array = ascending_array.reverse
        descending_array[0..9]
      end


      def singles_points_scored
        singles_games.inject(0) do |total, game|
          team_game = game.find_team_game_by_player_id(self.id)
          total += team_game.score
        end
      end

      def doubles_points_scored
        doubles_games.inject(0) do |total, game|
          team_game = game.find_team_game_by_player_id(self.id)
          total += team_game.score
        end
      end

      def singles_points_against
        singles_games.inject(0) do |total, game|
          team_game = game.find_team_game_by_player_id(self.id)
          other_team_game_array = game.team_games.reject {|tg| tg == team_game}
          other_team_game = other_team_game_array[0]
          total += other_team_game.score
        end
      end

      def doubles_points_against
        doubles_games.inject(0) do |total, game|
          team_game = game.find_team_game_by_player_id(self.id)
          other_team_game_array = game.team_games.reject {|tg| tg == team_game}
          other_team_game = other_team_game_array[0]
          total += other_team_game.score
        end
      end


      # def singles_points_differential
      #   singles_wins - singles_losses
      # end



      def self.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
      end

      def self.new_token
        SecureRandom.urlsafe_base64
      end

      def remember
        self.remember_token = Player.new_token
        update_attribute(:remember_digest, Player.digest(remember_token))
      end

      def authenticated?(remember_token)
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
      end

     def forget
        update_attribute(:remember_digest, nil)
     end

end
