class Movie < ApplicationRecord
  mount_uploader :movie_image, MovieImageUploader
end
