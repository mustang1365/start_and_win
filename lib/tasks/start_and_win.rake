namespace :start_and_win do
  desc "Create new result tables"
  task :table_results => :environment do
    FootballTableResult.create_new_empty_table
  end
end