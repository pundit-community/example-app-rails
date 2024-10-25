FactoryBot.define do
  factory :user do
    factory :registered_user do
      sequence(:email) { |n| "testuser#{n}@example.com" }
      password { '1234567A' }
      password_confirmation { '1234567A' }

      factory :administrator do
        administrator { true }
      end
    end
  end
end
