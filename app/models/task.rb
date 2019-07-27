# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  name        :string(30)       not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#

class Task < ApplicationRecord
  validates :name, presence: true
  validates :name, length: {maximum: 30}
  validate :validate_name_not_including_comma

  scope :record_entity_expansion, -> {order(created_at: :desc)}

  belongs_to :user
  has_one_attached :image

  def self.ransackable_attributes(auth_object = nil)
    %w[name created_at]
  end
  def self.ransackable_associations(auth_object = nil)
    []
  end

end

private

def validate_name_not_including_comma
  errors.add(:name, 'にカンマを含めることはできません') if name&.include?(',')
end

