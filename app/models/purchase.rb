class Purchase < ApplicationRecord
  belongs_to :movie
  belongs_to :buyer, class_name: 'User'
end
