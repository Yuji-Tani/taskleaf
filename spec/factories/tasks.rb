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

FactoryBot.define do
  factory :task do
    name {'テストを書く'}
    description {'Rspec&Capybara&FactoryBotを準備する'}
    user
  end
end
