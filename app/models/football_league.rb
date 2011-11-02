# == Schema Information
#
# Table name: football_leagues
#
#  id             :integer(4)      not null, primary key
#  league_name    :string(255)
#  country_id     :integer(4)
#  type_league_id :integer(4)
#  rounds         :text
#  created_at     :datetime
#  updated_at     :datetime
#

class FootballLeague < ActiveRecord::Base
  belongs_to :country
  has_many :football_teams, :order => :team_name
  has_many :football_matches

  has_many :football_table_results

  serialize :rounds
  scope :default,  {:order=>"country_id"}


end

