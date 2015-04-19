class AddUserIdFields < ActiveRecord::Migration
  def change
    add_reference :settings, :user, index: true
    add_reference :mileages, :user, index: true
  end
end
