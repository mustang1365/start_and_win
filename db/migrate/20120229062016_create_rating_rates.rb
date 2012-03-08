class CreateRatingRates < ActiveRecord::Migration
  def change
    create_table :rating_rates do |t|
      t.float :begin_rating, :default => 0.0
      t.float :end_rating, :default => 0.0
      t.float :rate_of_payment, :default => 0.0
      t.timestamps
    end
  end
end
