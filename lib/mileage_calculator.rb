class MileageCalculator
  def self.labels(date_from)
    date_from = date_from.to_datetime
    date_to    = date_from.to_time.advance(months: 11).to_date
    date_range = date_from..date_to

    date_months = date_range.map { |d| Date.new(d.year, d.month, 1) }.uniq
    date_months.map { |d| d.strftime '%B' }
  end

  def self.expected(yearly_milage, starting_milage, term_length)
    monthly_mileage = yearly_milage.to_i / 12
    current = starting_milage.to_i
    out = []

    term_length.times do
      current += monthly_mileage
      out << current
    end

    out
  end

  # rubocop:disable AbcSize
  def self.actual(user_id, term_length, starting_date)
    results = ((starting_date.to_datetime)..starting_date.to_datetime +
              (term_length - 1).months).map { |d| [d.year, d.month] }.uniq

    grouped_mileages(user_id).sort.each do |date, data|
      results[results.index([date.year, date.month])] << data.last.amount
    end

    results.flat_map { |_, _, amount| amount || 0 }
  end

  def self.grouped_mileages(user_id)
    Mileage.where(user_id: user_id).order(:date).group_by { |mile| mile.date.end_of_month }
  end
end
