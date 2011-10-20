Dir.foreach("#{Rails.root}/db/seeds") do |file|
  load "#{Rails.root}/db/seeds/#{file}" unless [".",".."].include? file
end
