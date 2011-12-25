Dir["#{Rails.root}/config/fixtures/question_seeds/*.yml"].entries.each do |entry|
  Question.create_from_hash(YAML::load_file(entry))
end