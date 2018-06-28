class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  mount_base64_uploader :image, ImageUploader
  validates :nickname, presence: true, uniqueness: true
  validates :password, length: { in: 8..20 }, unless: :blank_password?

  def blank_password?
    self.password.blank?
  end
end
