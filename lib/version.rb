class Version
  MAJOR = 0
  MINOR = 7
  PATCH = 2

  def self.current
    "#{MAJOR}.#{MINOR}.#{PATCH}"
  end
end
