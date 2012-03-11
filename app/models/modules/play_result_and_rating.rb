module Modules::PlayResultAndRating
  def self.included(base)
    base.class_eval do
      has_many :play_results, :as => :competition, :dependent => :destroy
      has_many :ratings, :through => :play_results, :dependent => :destroy

      #set rating for competition
      def recalculate_rating
        update_column(:rating, self.class.joins(:ratings).where(:id => self.id).select("AVG(ratings.total_score) AS average_rating").first.average_rating || 0.0)
      end
    end
  end
end