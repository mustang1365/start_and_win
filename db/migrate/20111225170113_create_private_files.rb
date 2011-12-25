class CreatePrivateFiles < ActiveRecord::Migration
  def change
    create_table :private_files do |t|
      t.text :file_content

      t.timestamps
    end
  end
end
