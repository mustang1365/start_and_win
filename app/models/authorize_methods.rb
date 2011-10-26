module AuthorizeMethods
  def self.included(base)
    def authorize!(options = nil)
      @options = options
      @ability ||= current_user.current_ability
      unless has_access_to_controller?
        raise AccessException
      end
    end

    private
    def has_access_to_controller?
      @ability[:controllers][controller_name].present? && has_access_to_action? && check_special_methods?
    end

    def has_access_to_action?
       @ability[:controllers][controller_name].keys.include?('all') || @ability[:controllers][controller_name].keys.include?(action_name)
    end

    def check_special_methods?
      @ability[:controllers][controller_name][action_name].nil? ||
              Ability.send(controller_name, action_name, current_user)
    end
  end
end