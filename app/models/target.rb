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
  MAX_TARGETS_PER_USER = 10

  belongs_to :topic
  belongs_to :user

  acts_as_mappable default_units: :kms,
                   default_formula: :flat,
                   distance_field_name: :distance,
                   lat_column_name: :latitude,
                   lng_column_name: :longitude

  validates :title, presence: true, uniqueness: true
  validates :latitude, :longitude, presence: true

  validate :target_limit_per_user

  def self.search_compatible_targets(new_target)
    Target.where.not(user_id: new_target.user_id).each do |target|
      origin = [target.latitude, target.longitude]
      dist = new_target.distance_to(origin) * 1000
      is_within_distance = dist <= target.area_length + new_target.area_length
      puts 'Compatible target found!' if is_within_distance
    end
  end

  private

  def target_limit_per_user
    if user.targets.count >= MAX_TARGETS_PER_USER
      errors.add(:user, "#{I18n.t('api.targets.create.limit_reached', limit: MAX_TARGETS_PER_USER)}")
    end
  end
end
