module Modules::PlayResultAndRating
  def self.included(base)
    base.class_eval do
      has_many :play_results, :as => :competition, :dependent => :destroy
      has_many :ratings, :through => :play_results, :dependent => :destroy
    end
  end
end