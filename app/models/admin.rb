class Admin < ApplicationRecord
  attribute :resend_ref_code, :boolean
  has_secure_password validations: false
  has_secure_password :ref_code, validations: false

  enum admin_type: [:admin, :super_admin]
  enum status: [:pre_registered, :registered, :suspended, :retired]
                #yellow | blue | red | grey

  validates :email, :admin_type, presence: true, on: :create
  validates :email,         format: { with: /\A[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\z/, message: "Email no cumple formato" },
                            uniqueness: { case_sensitive: false }

  validates :first_name,    presence: { message: 'Nombre no puede quedar en blanco'}, on: :update
  validates :last_name,     presence: { message: 'Apellido no puede quedar en blanco'}, on: :update
  validates :password,      format: { with: PASSWORD_FORMAT,
                                 message: "Clave no cumple con formato requerido"
                                },
                            length: { minimum: 6, message: "Clave minimo de 6 caracteres" },
                            on: :update
  validates :password, confirmation: { message: "Confirmacion no es igual a Contraseña" }, on: :update

  # CALLBACKS
  before_update :ref_code_request

  # INSTANCE METHODS
  def ref_code_request
    # if attribute is true

    # send new request to admin user
  end

  def set_ref_code
    new_ref_code = SecureRandom.base64(28)
    self.ref_code = new_ref_code
    self.ref_code_expiry = DateTime.current + 1.day
    self.save(validate: false)
    
    new_ref_code
  end

  def send_ref_code
    self.status = :pre_registered
    ref_number = set_ref_code

    # send registration email to admin
    NotificationsMailer.with(
      reference_number: ref_number,
      admin_user: self.id
    ).registration_email.deliver_later

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

  def reset_attempts
    self.login_attempts = 3
    self.save(validate: false)
  end

  def register_user
    self.status = :registered
    self.save validate: false
    # Set up email notification to admin user: Your account has been registered
  end

  def suspend_user
    self.status = :suspended
    # Set up email notification to admin user: Your account has been suspended
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

end
