roles = YAML.load_file("#{Rails.root}/config/yml_for_seeds/roles.yml")
roles.each do |key,value|
  role = (role_from_db = Role.find_by_name(key)).nil? ? Role.create(:name => key) : role_from_db
  value['permissions'].split(',').each do |permission_name|
    role.permissions << Permission.find_by_name(permission_name)
  end
end