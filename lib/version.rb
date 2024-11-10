class Version
  MAJOR = 0
  MINOR = 1
  PATCH = 5

  def self.current
    "#{MAJOR}.#{MINOR}.#{PATCH}"
  end
end
