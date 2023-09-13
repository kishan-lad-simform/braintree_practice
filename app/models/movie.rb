class Movie < ApplicationRecord
  mount_uploader :movie_image, MovieImageUploader
  has_many :purchases
  has_many :buyers, through: :purchases
  
end
