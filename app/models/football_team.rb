class FootballTeam < ActiveRecord::Base
  belongs_to :football_league
end

# == Schema Information
#
# Table name: football_teams
#
#  id                 :integer(4)      not null, primary key
#  football_league_id :integer(4)
#  team_name          :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#

