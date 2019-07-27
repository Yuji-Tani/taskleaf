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

  # デフォルトのソート順指定
  scope :record_entity_expansion, -> {order(created_at: :desc)}

  belongs_to :user
  has_one_attached :image

  def self.csv_attributes
    return ["name", "description", "created_at", "updated_at"]
  end

  def self.generate_csv
    CSV.generate(headers: true) do |csv|
      csv << csv_attributes
      all.each do |task|
        csv << csv_attributes.map{|attr| task.send(attr)}
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      task = new
      task.attributes = row.to_hash.slice(*csv_attributes)
      task.save!
    end
  end

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

