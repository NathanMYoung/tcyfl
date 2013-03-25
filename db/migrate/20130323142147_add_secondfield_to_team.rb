class AddSecondfieldToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :secondfield, :integer
  end
end
