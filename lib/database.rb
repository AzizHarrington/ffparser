class Database
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def sort_by(fields, order)
    fields.reverse.reduce(@data) do |acc, field|
      do_sort(acc, field, order)
    end
  end

  private

  def do_sort(data, field, order)
    data.sort do |a, b|
      if order == :asc
        comp(a, b, field)
      elsif order == :desc
        comp(b, a, field)
      end
    end
  end

  def comp(a, b, field)
    get(a, field) <=> get(b, field)
  end

  def get(record, field)
    record.send(field)
  end
end
