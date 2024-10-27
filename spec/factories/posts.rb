FactoryBot.define do
  factory :post do
    factory :valid_post do
      sequence(:name) { |n| "Post #{n}" }
      user { FactoryBot.create(:registered_user) }
      blog { FactoryBot.create(:valid_blog) }

      factory :published_post do
        publish { true }
      end

      factory :unpublished_post do
        publish { false }
      end
    end
  end
end
