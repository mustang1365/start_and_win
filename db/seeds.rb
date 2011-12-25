def run_seeds(paths)
  paths.each do |path|
    puts "Loading db/seeds/#{path.split(File::SEPARATOR).last}"
    load(path)
  end
end

all_file_paths = Dir[Rails.root.join('db', 'seeds', '*.rb').to_s]

run_seeds(all_file_paths)

