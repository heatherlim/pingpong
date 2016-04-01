class AddCourseIdToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :course_id, :integer
  end
end
