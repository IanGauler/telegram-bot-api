class Version
  MAJOR = 0
  MINOR = 1
  PATCH = 4

  def self.current
    "#{MAJOR}.#{MINOR}.#{PATCH}"
  end
end
