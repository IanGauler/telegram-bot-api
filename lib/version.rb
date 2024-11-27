class Version
  MAJOR = 2
  MINOR = 4
  PATCH = 4

  def self.current
    "#{MAJOR}.#{MINOR}.#{PATCH}"
  end
end
