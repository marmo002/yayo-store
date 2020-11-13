class Admin < ApplicationRecord

  has_secure_password validations: false
  has_secure_password :ref_code, validations: false

  enum admin_type: [:admin, :super_admin]
  enum status: [:pre_registered, :registered, :suspended, :retired]

  validates :email, :admin_type, presence: true, on: :create
  validates :email, format: { with: /\A[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\z/, message: "Email no cumple formato" },
                              uniqueness: { case_sensitive: false }
  validates :first_name, :last_name, :password, presence: true, on: :update
  validates :password, confirmation: true, on: :update
  validates :password, length: { in: 6..20 }, on: :update
  validates :password, format: { with: PASSWORD_FORMAT,
                                 message: "Clave no cumple con formato requerido"
                                }, on: :update

  # INSTANCE METHODS
  def is_ref_code_expired?
    DateTime.current < self.ref_code_expiry ? false : true
  end
end
