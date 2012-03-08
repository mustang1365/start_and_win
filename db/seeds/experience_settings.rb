levels_hash = YAML::load_file("#{Rails.root}/config/fixtures/experience_settings.yml")
levels_hash.each do |hash|
  if ExperienceSetting.find_by_competition_name(hash['competition_name']).nil?
     ExperienceSetting.create(:competition_name => hash['competition_name'],
                              :iq_for_participant => hash['iq_for_participant'],
                              :iq_for_creator => hash['iq_for_creator']
     )
  end
end