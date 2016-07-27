##
# Mileage model
#
require 'csv'

class Mileage < ActiveRecord::Base
  belongs_to :user

  validates :amount, presence: true, numericality: { greater_than: 0,
                                                     less_than_or_equal_to:
                                                      50_000 }
  validates :date, date: true

  def self.to_csv
    attributes = %w(date amount)

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |record|
        csv << attributes.map { |attr| record.send(attr) }
      end
    end
  end
end
