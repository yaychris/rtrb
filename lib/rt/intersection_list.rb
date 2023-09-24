class IntersectionList < Array
  def hit
    sort_by(&:t).reject { |i| i.t.negative? }.first
  end
end
