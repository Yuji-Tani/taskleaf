# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  name            :string           not null
#  email           :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  admin           :boolean          default(FALSE), not null
#

FactoryBot.define do
  factory :user do
    name {'テストユーザー'}
    email {'test1@example.com'}
    password {'password'}
  end
end
