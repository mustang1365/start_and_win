class FootballMatch < ActiveRecord::Base
  belongs_to :team1, :class_name=> "FootballTeam"
  belongs_to :team2, :class_name=> "FootballTeam"
  belongs_to :league, :class_name => "FootballLeague"

end
