module SessionsHelper

 # Logs in the given player.
 def log_in(player)
   session[:player_id] = player.id
 end

 # Remembers a player in a persistent session.
 def remember(player)
   player.remember
   cookies.permanent.signed[:player_id] = player.id
   cookies.permanent[:remember_token] = player.remember_token
 end

 # Returns the current logged-in player (if any).
 def current_player
  if (player_id = session[:player_id])
      @current_player ||= Player.find_by(id: player_id)
  elsif (player_id = cookies.signed[:player_id])
    player = Player.find_by(id: player_id)
    if player && player.authenticated?(cookies[:remember_token])
      log_in player
      @current_player = player
    end
  end
 end

 # Returns true if the player is logged in, false otherwise.
 def logged_in?
   !current_player.nil?
 end

def forget(player)
   player.forget
   cookies.delete(:player_id)
   cookies.delete(:remember_token)
 end

 # Logs out the current player.
 def log_out
   forget(current_player)
   session.delete(:player_id)
   @current_player = nil
 end

end
