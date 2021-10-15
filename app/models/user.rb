class User < ApplicationRecord
  has_secure_password

  enum role: [:it_admin, :qa, :inventory_manager, :sales_manager]

  attr_accessor :skip_some_callbacks

  validates :role, presence: true
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

  before_validation :set_password
  skip_callback :validation, :before, :set_password, unless: :skip_some_callbacks

  private
    def set_password 
      self.password = SecureRandom.hex(4)
    end
end
