class CreatePlayingfields < ActiveRecord::Migration
  def change
    create_table :playingfields do |t|
      t.string :fieldname
      t.string :street
      t.string :city
      t.string :state
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
