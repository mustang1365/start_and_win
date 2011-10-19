Permission.destroy_all
ModelArea.destroy_all
ControllerArea.destroy_all
permissions = YAML.load_file("#{Rails.root}/config/yml_for_seeds/permissions.yml")
permissions.each do |key, value|
  new_permission = Permission.create(:name => key)
#Set ability to access controllers
  if value['controller_area'].present?
    value['controller_area'].each do |controller_hash|
      controller_hash['action_names'].split(',').each do |action_name|
        ControllerArea.create(:controller_name => controller_hash['controller'], :action_name => action_name,
                              :check_method => controller_hash['check_method'], :permission_id => new_permission.id)
      end
    end
  end
#Set ability to access models
  if value['model_area'].present?
    value['model_area'].each do |model_hash|
      ModelArea.create(:model_name => model_hash['model'], :check_method => model_hash['check_method'],
                       :permission_id =>new_permission.id)
    end
  end
end




