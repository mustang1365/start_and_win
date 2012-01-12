levels_hash = YAML::load_file("#{Rails.root}/config/fixtures/education_levels.yml")
levels_hash.each do |hash|
  if EducationLevel.find_by_name(hash['name']).nil?
    dl = EducationLevel.new(:name => hash['name'])
    dl.save
  end
end