levels_hash = YAML::load_file("#{Rails.root}/config/fixtures/difficulty_levels.yml")
levels_hash.each do |hash|
  if DifficultyLevel.find_by_name(hash['name']).nil?
    dl = DifficultyLevel.new(:name => hash['name'])
    dl.build_difficulty_level_setting(:iq_level => hash['iq_level'])
    dl.save
  end
end