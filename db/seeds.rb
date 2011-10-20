# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
params = YAML::load(File.open "#{Rails.root}/config/seeds/countries.yml")
params.each do  |country|
  new_country = Country.create(:name => country["name"])
  country["league"].each do |league|
    new_league = new_country.football_leagues.create(:league_name => league["name"])
    league["football_teams"].each do |team|
      new_league.football_teams.create(team)
    end
  end
end
