class FootballTableResult < ActiveRecord::Base
  belongs_to :football_league
  belongs_to :football_team


  class << self


    def update_stats(params)
      update_stats_for_team(params[:team1], params[:goals_1], params[:goals_2])
      update_stats_for_team(params[:team2], params[:goals_2], params[:goals_1])
    end

    def create_new_empty_table
      FootballLeague.all.map do |league|
        league.football_teams.each do |team|
          league.football_table_results.create(:football_team => team)
        end
      end
    end

    def update_stats_for_team(team_id, goals_in, goals_out)
      team = FootballTableResult.where(:football_team_id => team_id).first
      team.update_attributes(conditions(goals_in, goals_out, team).merge(:goals_in => team.goals_in + goals_in,
                                                                   :goals_out => team.goals_out + goals_out))
    end

    def conditions(goals_in, goals_out, team)
      if goals_in.to_i == goals_out.to_i
        {:draws => (team.draws + 1)}
      elsif goals_in.to_i > goals_out.to_i
        {:wins => team.wins+1}
      else
        {:loses=> (team.loses + 1)}
      end
    end

  end



end

# == Schema Information
#
# Table name: football_table_results
#
#  id                 :integer(4)      not null, primary key
#  football_league_id :integer(4)
#  football_team_id   :integer(4)
#  play_matches       :integer(4)      default(0)
#  goals_in           :integer(4)      default(0)
#  goals_out          :integer(4)      default(0)
#  wins               :integer(4)      default(0)
#  draws              :integer(4)      default(0)
#  loses              :integer(4)      default(0)
#  goal_diff          :integer(4)      default(0)
#  created_at         :datetime
#  updated_at         :datetime
#

