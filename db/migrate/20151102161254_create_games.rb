class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.datetime :match_time
      t.integer :table_id

      t.timestamps null: false
    end
  end
end
