# == Schema Information
#
# Table name: football_matches
#
#  id                 :integer(4)      not null, primary key
#  team1_id           :integer(4)
#  team2_id           :integer(4)
#  football_league_id :integer(4)
#  round              :string(255)
#  started_at         :datetime
#  finished_at        :datetime
#

class FootballMatch < ActiveRecord::Base
  belongs_to :team1, :class_name=> "FootballTeam"
  belongs_to :team2, :class_name=> "FootballTeam"
  belongs_to :football_league, :class_name => "FootballLeague"

  class << self
    def create_and_update_stats(params)
       FootballTableResult.update_stats(params)
       create(params)

    end
  end

end

