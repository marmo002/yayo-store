class AdminRegistration
  include ActiveModel::Validations

  attr_accessor :email, :reference_code

  def initialize(attributes = {})
    @email = attributes[:email]
    @reference_code = attributes[:reference_code]
  end

  validates :email,               format: { with: /\A[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\z/, message: "Error en Correo electronico" }
  validates :reference_code,      length: { is: 40, message: "Error en Codigo de referencia" }
end
