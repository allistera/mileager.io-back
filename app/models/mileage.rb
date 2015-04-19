##
# Mileage model
#
class Mileage < ActiveRecord::Base
  belongs_to :user

  validates :amount, presence: true, numericality: { greater_than: 0,
                                                     less_than_or_equal_to:
                                                      50_000 }
  validates :date, date: true
end
