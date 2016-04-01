class CreatePlayersTeams < ActiveRecord::Migration
  def change
    create_table :players_teams do |t|
      t.integer :player_id
      t.integer :team_id

      t.timestamps null: false
    end
  end
end
