# == Schema Information
#
# Table name: targets
#
#  id          :bigint(8)        not null, primary key
#  title       :string           not null
#  area_length :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  topic_id    :bigint(8)
#  latitude    :float            not null
#  longitude   :float            not null
#  user_id     :bigint(8)
#
# Foreign Keys
#
#  fk_rails_...  (topic_id => topics.id)
#  fk_rails_...  (user_id => users.id)
#

class Target < ApplicationRecord
  MAXIMUM_NUMBER_OF_TARGETS_PER_USER = 10

  belongs_to :topic
  belongs_to :user

  validates :title, presence: true, uniqueness: true
  validates :latitude, :longitude, presence: true

  validate :target_limit_per_user

  private

  def target_limit_per_user
    if user.targets.size >= MAXIMUM_NUMBER_OF_TARGETS_PER_USER
      errors.add(:user, "#{I18n.t('api.targets.create.limit_reached')} (#{MAXIMUM_NUMBER_OF_TARGETS_PER_USER})")
    end
  end
end
