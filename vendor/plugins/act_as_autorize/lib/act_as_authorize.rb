module ActAsAuthorize
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods

    def act_as_authorize(options = {})

      write_inheritable_attribute(:authorize_options, options)

      class_inheritable_reader :authorize_options

      init_before_filters(authorize_options)

    end

    def init_before_filters(options = {})

      # Don't authorize
      # if check_proc return true
      class_eval do
        def check_access_to_action
          if  authorize_options[:check_proc].nil? || (authorize_options[:check_proc].present? && !authorize_options[:check_proc].call(current_user, params))
            authorize!
          end
        end
      end

      module_eval(%[
        before_filter :check_access_to_action #{options[:except_action].nil? ? "" : ", :except => [#{[options[:except_action]].flatten.map { |s| ":#{s}" }.join(", ")}]"} #{options[:only_action].nil? ? "" : ", :only => [#{[options[:only_action]].flatten.map { |s| ":#{s}" }.join(", ")}]"}
                  ])

    end
  end
end