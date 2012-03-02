#action_in_controller_hash?(hash) - return true if hash has current controller as key and action array include current action
module GeneralHelper
  #return true if hash has current controller as key and action array include current action
  def action_in_controller_hash?(hash)
    hash && hash[controller_name.to_sym].present? &&
        (hash[controller_name.to_sym].include?(action_name.to_sym) || hash[controller_name.to_sym].include?(:all))
  end
end