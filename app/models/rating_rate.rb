#+-----------------+----------+------+-----+---------+----------------+
#| Field           | Type     | Null | Key | Default | Extra          |
#+-----------------+----------+------+-----+---------+----------------+
#| id              | int(11)  | NO   | PRI | NULL    | auto_increment |
#| begin_rating    | float    | YES  |     | 0       |                |
#| end_rating      | float    | YES  |     | 0       |                |
#| rate_of_payment | float    | YES  |     | 0       |                |
#+-----------------+----------+------+-----+---------+----------------+
class RatingRate < ActiveRecord::Base
  validates :rate_of_payment, :begin_rating, :end_rating, :presence => true
  validates :begin_rating, :end_rating, :numericality => true
  validates_numericality_of :rate_of_payment, :less_than_or_equal_to => 1

  scope :for_rating, lambda {|rating| where("begin_rating > :rating AND end_rating <= :rating", :rating => rating)}

  #return coefficient for calculation for current average rating
  def self.coef_for_rating(average_rating)
    RatingRate.for_rating(average_rating).first.try(:rate_of_payment).to_f
  end
end
