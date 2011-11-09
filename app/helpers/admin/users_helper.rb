#encoding: utf-8
module Admin::UsersHelper
  def toggle_status_confirm_msg(user = nil)
     "Вы уверены что хотите деактивировать активировать пользователя #{user.full_name || user.user_name}?" if user
  end
end
