class Version
  MAJOR = 0
  MINOR = 3
  PATCH = 0

  def self.current
    "#{MAJOR}.#{MINOR}.#{PATCH}"
  end
end
