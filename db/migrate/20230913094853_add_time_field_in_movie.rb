class AddTimeFieldInMovie < ActiveRecord::Migration[7.0]
  def change
    remove_column :movies, :show_time
  end
end
