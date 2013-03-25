class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :community
      t.string :weight
      t.string :level

      t.timestamps
    end
  end
end
