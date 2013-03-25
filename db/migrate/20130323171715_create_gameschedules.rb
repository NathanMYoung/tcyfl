class CreateGameschedules < ActiveRecord::Migration
  def change
    create_table :gameschedules do |t|
      t.integer :game1
      t.integer :game2
      t.integer :game3
      t.integer :game4
      t.integer :game5
      t.integer :game6
      t.integer :game7
      t.integer :game8
      t.integer :game9

      t.timestamps
    end
  end
end
