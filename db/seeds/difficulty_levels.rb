levels_hash = YAML::load_file("#{Rails.root}/config/fixtures/difficulty_levels.yml")
levels_hash.each do |hash|
  if DifficultyLevel.find_by_name(hash['name']).nil?
    DifficultyLevel.create(:name => hash['name'])
  end
end