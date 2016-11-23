class AddDefaultsToUser < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :highscore, :integer, default: 0
    change_column :users, :totalPlays, :integer, default: 0
    change_column :users, :isAdmin, :boolean, default: false
  end
end
