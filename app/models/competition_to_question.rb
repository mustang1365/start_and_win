class CompetitionToQuestion < ActiveRecord::Base
  belongs_to :competition
  belongs_to :question
  accepts_nested_attributes_for :question
end
