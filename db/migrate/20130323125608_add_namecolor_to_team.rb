class AddNamecolorToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :namecolor, :string
  end
end
