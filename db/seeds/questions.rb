#Dir["#{Rails.root}/config/fixtures/question_seeds/*.yml"].entries.each do |entry|
#  Question.create_from_hash(YAML::load_file(entry))
#end

levels_hash = YAML::load_file("#{Rails.root}/config/fixtures/question_seeds/test_questions.yml")
levels_hash.each do |q_hash|
  if Question.find_by_text(q_hash['question']).nil?
    question = Question.new(:text => q_hash['question'])
    #create variants
    q_hash['variants'].each do |variant|
      question.variants.build(:text => variant['name'], :answer => variant['answer'])
    end
    #create category
    if q_hash['category'].present?
      main_category = MainCategory.find_by_title(q_hash['category']) || MainCategory.create(:title => q_hash['category'])
      question.build_model_to_main_category(:main_category_id => main_category.id)
      if q_hash['sub_categories'].present?
        q_hash['sub_categories'].split(',').each do |sub_c|
          sub_cat = SubCategory.find_by_title(sub_c) || SubCategory.create(:title => sub_c, :main_category => main_category)
          question.model_to_main_category.model_to_main_category_to_sub_categories.build(:sub_category_id => sub_cat.id)
        end
      end
    end
    #create play condition
    if  q_hash['play_condition'].present?
      play_condition = PlayCondition.create(:participation_points => q_hash['play_condition']['participation_points'],
                                            :points_to_play => q_hash['play_condition']['points_to_play'],
                                            :win_points => q_hash['play_condition']['win_points'],
                                            :time_limit => q_hash['play_condition']['time_limit'],
                                            :difficulty_level_id => DifficultyLevel.find_by_name(q_hash['play_condition']['difficulty_level']).id,
      )
    end
    user = User.find_by_email('cm_maker@test.tt')
    question.user = user if user
    question.play_condition = play_condition if play_condition
    if question.valid?
      question.save!
    else
      puts "Can't save question with name #{question.text}!! #{question.errors}'"
    end
  end
end