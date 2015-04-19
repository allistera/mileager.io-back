class AddWalkthroughFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :walkthrough, :boolean, default: true
  end
end
