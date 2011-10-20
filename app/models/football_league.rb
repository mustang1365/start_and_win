class FootballLeague < ActiveRecord::Base
  belongs_to :country
  has_many :football_teams
  serialize :rounds

end
