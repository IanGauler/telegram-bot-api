class Version
  MAJOR = 0
  MINOR = 2
  PATCH = 2

  def self.current
    "#{MAJOR}.#{MINOR}.#{PATCH}"
  end
end
