class PlayCondition < ActiveRecord::Base
  belongs_to :model, :polymorphic => true
  belongs_to :difficulty_level
end
