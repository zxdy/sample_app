class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.date :logdate
      t.string :poolname
      t.string :serverlist
      t.datetime :failtime

      t.timestamps
    end
  end
end
