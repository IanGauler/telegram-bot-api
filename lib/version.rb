class Version
  MAJOR = 0
  MINOR = 1
  PATCH = 9

  def self.current
    "#{MAJOR}.#{MINOR}.#{PATCH}"
  end
end
