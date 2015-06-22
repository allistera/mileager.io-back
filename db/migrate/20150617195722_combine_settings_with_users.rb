class CombineSettingsWithUsers < ActiveRecord::Migration
  def up
    add_column :users, :starting_date, :date
    add_column :users, :term_length, :string
    add_column :users, :yearly_mileage, :string
    add_column :users, :starting_mileage, :string

    # Port data from settings accross to the users row
    translation = {
      "STARTING_MONTH" => "starting_date",
      "DURATION" => "term_length",
      "YEARLY_MILEAGE" => "yearly_mileage",
      "STARTING_MILEAGE" => "starting_mileage"
    }

    Setting.all.each do |post|
      Setting.connection.execute("UPDATE users SET #{translation[post.name]} = '#{post.value}' WHERE id = #{post.user_id};")
    end
  end

  def down
    remove_column :users, :starting_date
    remove_column :users, :term_length
    remove_column :users, :yearly_mileage
    remove_column :users, :starting_mileage
  end
end
