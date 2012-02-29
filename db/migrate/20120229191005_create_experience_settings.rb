class CreateExperienceSettings < ActiveRecord::Migration
  def change
    create_table :experience_settings do |t|
      t.string :competition_name
      t.float :iq_for_participant, :default => 0.0
      t.float :iq_for_creator, :default => 0.0
      t.timestamps
    end
  end
end
