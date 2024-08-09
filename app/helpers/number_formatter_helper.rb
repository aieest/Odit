module NumberFormatterHelper
  def format_large_number(number)
    case
    when number >= 1_000_000_000
      "#{(number / 1_000_000_000.0).round(2)}B"
    when number >= 1_000_000
      "#{(number / 1_000_000.0).round(2)}M"
    when number >= 1_000
      "#{(number / 1_000.0).round(2)}K"
    else
      number.to_s
    end
  end
end