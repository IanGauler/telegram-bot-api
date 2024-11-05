class Version
  MAJOR = 0
  MINOR = 0
  PATCH = 3

  def self.current
    "#{MAJOR}.#{MINOR}.#{PATCH}"
  end
end
