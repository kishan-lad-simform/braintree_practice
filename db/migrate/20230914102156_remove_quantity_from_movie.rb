class RemoveQuantityFromMovie < ActiveRecord::Migration[7.0]
  def change
    remove_column :movies, :quantity
  end
end
