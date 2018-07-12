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
#
# Foreign Keys
#
#  fk_rails_...  (topic_id => topics.id)
#

class Target < ApplicationRecord
  belongs_to :topic

  validates :title, presence: true, uniqueness: true
  validates :latitude, :longitude, presence: true
end
