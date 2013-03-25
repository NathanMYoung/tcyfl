class AddScheduleidToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :scheduleid, :integer
  end
end
