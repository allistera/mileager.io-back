class CreateMileages < ActiveRecord::Migration
  def change
    create_table :mileages do |t|
      t.date :date
      t.float :amount

      t.timestamps
    end
  end
end
