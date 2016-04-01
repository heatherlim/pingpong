class Search

  def self.for(player)
    Player.where("lower(name) like ?", "%#{player}%".downcase)
  end

end