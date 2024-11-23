class Version
  MAJOR = 1
  MINOR = 0
  PATCH = 2

  def self.current
    "#{MAJOR}.#{MINOR}.#{PATCH}"
  end
end
