class SearchController < ApplicationController

  def index

   # keyword = params[:search][:keyword]
   @courses = Course.all
   player = params[:keyword]
   @players = Search.for(player)
   if @players.size == 1
     player = @players.first
     redirect_to player_path(player)
   elsif @players.size == 0
     flash.now.notice = "No results matching that query."
     render '/players/index'
   else
     render '/players/index'
   end
 end
  
end