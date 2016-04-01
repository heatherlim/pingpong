class PlayersController < ApplicationController

skip_before_action :require_login, only: [:new, :create]

  def index
    @players = Player.all
    @courses = Course.all
  end

  def show
    set_player
  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)
    if @player.save
      session[:player_id] = @player.id #we might need to change method here
      redirect_to players_path, :notice => "Ping Pong Rally On!"
    else
      render :new
    end
  end

  def rankings
    @top_ten_singles = Player.singles_top_ten
    @top_ten_doubles = Player.doubles_top_ten
    @top_ten_overall = Player.overall_top_ten
  end


  private
    def set_player
      @player = Player.find(params[:id])
    end

    def player_params
      params.require(:player).permit(:name, :email, :password, :course_id, :password_confirmation)
    end
end