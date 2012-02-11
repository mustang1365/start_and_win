#Plese place short description of methods here:
###############################################
#root_path_for - return root path depending on user type
###############################################
module UrlsHelper
  #return root path depending on user type
  def root_path_for(user)
    user.admin? ? admin_root_path : cabinet_user_root_path
  end
end