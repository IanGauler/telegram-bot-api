class Usuario
  attr_reader :email, :updated_on, :created_on
  attr_accessor :id

  def initialize(id, email)
    @email = email
    @id = id
  end
end
