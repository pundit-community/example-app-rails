FactoryBot.define do
  factory :post do
    factory :valid_post do
      sequence(:name) { |n| "Post #{n}" }
      user { FactoryBot.create(:registered_user) }
      blog { FactoryBot.create(:valid_blog) }
    end
  end
end
