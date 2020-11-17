class Admin < ApplicationRecord

  has_secure_password validations: false
  has_secure_password :ref_code, validations: false

  enum admin_type: [:admin, :super_admin]
  enum status: [:pre_registered, :registered, :suspended, :retired]
                #yellow | blue | red | grey

  validates :email, :admin_type, presence: true, on: :create
  validates :email, format: { with: /\A[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\z/, message: "Email no cumple formato" },
                              uniqueness: { case_sensitive: false }
  validates :first_name, :last_name, :password, presence: true, on: :update
  validates :password, confirmation: true, on: :update
  validates :password, length: { in: 6..20 }, on: :update
  validates :password, format: { with: PASSWORD_FORMAT,
                                 message: "Clave no cumple con formato requerido"
                                }, on: :update

  # CALLBACKS
  before_create :set_ref_code

  # INSTANCE METHODS
  def set_ref_code
    # new_ref_code = SecureRandom.base64(24)
    new_ref_code = "Dcxl6cqc4COBBrZvOVsT8eighDtcRasT"
    self.ref_code = new_ref_code
    self.ref_code_expiry = DateTime.current + 1.day

    new_ref_code
  end

  def ref_code_still_valid?
    DateTime.current < self.ref_code_expiry
  end

  def reduce_attempts
    self.login_attempts -= 1
    if self.login_attempts < 1
      self.suspend_user
    end
    self.save(validate: false)
  end

  # To be moved to helpers
  def code_expires_in
    if self.pre_registered?
      time = ref_code_expiry.in_time_zone("Lima")
      time.strftime("%b %d, %Y @ %I:%M %p")
    else
      "No applica"
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def suspend_user
    self.status = :suspended
    # Set up email notification to admin user: Your account has been suspended
  end

end
