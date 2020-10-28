class Brand < ApplicationRecord
  validates :name,     presence: { message: "Nombre no puede estar vacio" }
  validates :name,     uniqueness: { case_sensitive: false, message: "Marca ya existe!" }

  has_one_attached :logo

  # CUSTOM VALIDATION
  validate :image_validation

  def name=(name)
    write_attribute(:name, name.strip.downcase.titleize)
  end

  private

    def image_validation
        if !logo.blob.image?
          errors.add :logo, 'Archivo no es una imagen!'
        elsif logo.blob.image? && logo.blob.byte_size > (3 * 1024 * 1024) # Limit size 5MB
          errors.add :logo, 'El logo no puede ser mayor a 3MB'
        end
    end

end
