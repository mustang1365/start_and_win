class AddTimeToQuestion < ActiveRecord::Migration
  def change
    add_column :play_conditions, :time_limit, :integer, :default => 10
  end
end
