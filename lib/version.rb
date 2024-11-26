class Version
  MAJOR = 2
  MINOR = 1
  PATCH = 1

  def self.current
    "#{MAJOR}.#{MINOR}.#{PATCH}"
  end
end
