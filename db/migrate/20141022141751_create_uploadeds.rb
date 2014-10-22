class CreateUploadeds < ActiveRecord::Migration
  def change
    create_table :uploadeds do |t|
      t.string :name
      t.string :path

      t.timestamps
    end
  end
end
