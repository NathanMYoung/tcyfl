class CreateWeights < ActiveRecord::Migration
  def change
    create_table :weights do |t|
      t.string :weightClass

      t.timestamps
    end
  end
end
