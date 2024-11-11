class Version
  MAJOR = 0
  MINOR = 1
  PATCH = 6

  def self.current
    "#{MAJOR}.#{MINOR}.#{PATCH}"
  end
end
