# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  provider               :string           default("email"), not null
#  uid                    :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  allow_password_change  :boolean          default(FALSE)
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  name                   :string
#  nickname               :string           not null
#  image                  :string
#  email                  :string
#  tokens                 :json
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  latitude               :float
#  longitude              :float
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable, :confirmable
  include DeviseTokenAuth::Concerns::User

  has_many :targets, dependent: :destroy

  mount_base64_uploader :image, ImageUploader
  
  validates :nickname, presence: true, uniqueness: true
  validates :password, length: { in: 8..20 }, unless: :blank_password?

  def self.from_provider(provider, user_params)
    user_params.deep_symbolize_keys!
    where(provider: provider, uid: user_params[:id]).first_or_create do |user|
      user.password = Devise.friendly_token[0, 20]
      user.email = user_params[:email]
      user.name = user_params[:name]
      user.nickname = user_params[:first_name]
      user.remote_image_url = user_params.dig(:picture, :data, :url)
      user.confirm
    end
  end

  private

  def blank_password?
    self.password.blank?
  end
end
