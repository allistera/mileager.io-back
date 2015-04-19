##
# Setting model
#
class Setting < ActiveRecord::Base
  valid_name_entries = %w(STARTING_MONTH
                          YEARLY_MILEAGE
                          STARTING_MILEAGE
                          DURATION)

  belongs_to :user

  validates_inclusion_of :name, in: valid_name_entries
  validates :value, presence: true

  # Create custom update method rather than using update_all as it doesn't
  # validate data, this allows us to update if exists, or create if it doesn't.
  def self.update_setting(user_id, name, value)
    setting = Setting.where(name: name, user_id: user_id).limit(1).first
    setting.present? ? setting.update(value: value) :
      setting = Setting.create(name: name, value: value, user_id: user_id)
    setting.valid?
  end
end
