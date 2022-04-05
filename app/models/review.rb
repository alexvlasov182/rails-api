class Review < ApplicationRecord
  before_save :calculate_average_rating
  belongs_to :user
  belongs_to :book

  def calculate_average_rating
    self.average_rating = ((content_rating.to_f + recommend_rating.to_f) / 2).round(1)
  end
end
