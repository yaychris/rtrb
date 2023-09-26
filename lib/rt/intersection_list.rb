class IntersectionList < Array
  def initialize(intersections = [])
    super(intersections.sort_by(&:t))
  end

  def hit
    reject(&:negative?).first
  end
end
