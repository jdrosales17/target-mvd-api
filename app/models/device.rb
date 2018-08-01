# == Schema Information
#
# Table name: devices
#
#  id         :bigint(8)        not null, primary key
#  device_id  :string           not null
#  user_id    :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Device < ApplicationRecord
  belongs_to :user

  validates :device_id, presence: true, uniqueness: true
end
