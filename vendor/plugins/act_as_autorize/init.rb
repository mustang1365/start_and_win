require "act_as_authorize"

ActionController::Base.class_eval do
 include ActAsAuthorize
end