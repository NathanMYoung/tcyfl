class AddFirstfieldToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :firstfield, :integer
  end
end
