class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.date :gamedate
      t.time :gametime
      t.integer :hometeamId
      t.integer :visitorteamId
      t.integer :playingfieldId

      t.timestamps
    end
  end
end
