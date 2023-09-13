class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string :movie_name
      t.string :show_time
      t.string :price
      t.string :quantity
      t.string :movie_image

      t.timestamps
    end
  end
end
