class AutocompleteController < ApplicationController
  autocomplete :user, :login, :extra_data => [:id]
end
