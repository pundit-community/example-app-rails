FactoryBot.define do
  factory :blog do
    factory :valid_blog do
      sequence(:name) { |n| "Blog #{n}" }
      user { FactoryBot.create(:registered_user) }
      posts { [] }
    end
  end
end
