class Admin::FootballMatchesController < Admin::AdminController

  before_filter :find_league, :only => ["league_matches", "new"]

  def index
    @leagues = FootballLeague.default.includes(:country)
  end

  def league_matches
    @table_results = @league.football_table_results.includes(:football_team)
    @matches = @league.football_matches.limit(20)
  end

  def new
    @teams = @league.football_teams
    @match = @league.football_matches.new
  end

  def create
    FootballMatch.create_and_update_stats(params[:match])
    redirect_to admin_football_matches_path
  end

  private

  def find_league
    @league = FootballLeague.find(params[:id])
  end
end
