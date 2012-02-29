levels_hash = YAML::load_file("#{Rails.root}/config/fixtures/rating_rate.yml")
levels_hash.each do |hash|
  if RatingRate.find_by_begin_rating_and_end_rating(hash['begin_rating'], hash['end_rating']).nil?
    RatingRate.create(:begin_rating => hash['begin_rating'],:end_rating => hash['end_rating'],
                          :rate_of_payment => hash['rate_of_payment'])
  end
end