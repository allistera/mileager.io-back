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
    if setting.present
      setting.update(value: value)
    else
      setting = Setting.create(name: name, value: value, user_id: user_id)
    end
    setting.valid?
  end

  def self.create_for_user(user_id)
    defaults = {
      STARTING_MONTH: '01-' + Time.now.strftime('%m-%Y').to_s,
      YEARLY_MILEAGE: 10_000,
      STARTING_MILEAGE: 0,
      DURATION: 24
    }

    defaults.each do |setting, value|
      Setting.create(user_id: user_id, name: setting, value: value)
    end
  end
end
