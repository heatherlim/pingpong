class GamesController < ApplicationController 

  def index
    @games = Game.all
  end

  def new
    @game = Game.new
  end

  def create
    date = Time.now
    game = Game.create(match_time: date)
    team1_player_ids = [params[:game][:team1][0][:player_ids].to_i, params[:game][:team1][1][:player_ids].to_i]
    team2_player_ids = [params[:game][:team2][0][:player_ids].to_i, params[:game][:team2][1][:player_ids].to_i]
    team1 = Team.find_or_create_by_player_ids(team1_player_ids)
    team2 = Team.find_or_create_by_player_ids(team2_player_ids)
    team_game_one = TeamGame.create(team_id: team1.id, game_id: game.id)
    team_game_two = TeamGame.create(team_id: team2.id, game_id: game.id)
    team_game_one.update(score: params[:game][:team1][1][:team_games][:score])
    team_game_two.update(score: params[:game][:team2][1][:team_games][:score])
    message = generate_message(team_game_one, team_game_two)
    slackbot = Slackbot.new
    slackbot.generate(message)
    slackbot.deliver
    redirect_to games_path
  end

  def generate_message(teamgame1, teamgame2)
    team1_players = teamgame1.team.players
    team1_player_names = team1_players.map {|player| player.name}
    team1_string = team1_player_names.join(" & ") + ": " + teamgame1.score.to_s
    team2_players = teamgame2.team.players
    team2_player_names = team2_players.map {|player| player.name}
    team2_string = team2_player_names.join(" & ") + ": " + teamgame2.score.to_s
    "GAME JUST PLAYED:\n#{team1_string}\n #{team2_string}"
  end

  def show
    @game = Game.find(params[:id])
  end

  def edit
    set_game
    @team1 = @game.team_one
    @team2 = @game.team_two
  end

  def update
  end

  def destroy
    set_game
    @game.destroy
    redirect_to games_path
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:match_time, :table_id, :teams_attributes => [], :team_games => [], :player_ids => [])
  end

end