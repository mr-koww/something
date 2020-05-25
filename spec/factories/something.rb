FactoryBot.define do
  factory :something do
    sequence(:title) { |index| "Title № #{index}" }
    sequence(:created_at) { |index| Time.current - index.minutes }
  end
end
