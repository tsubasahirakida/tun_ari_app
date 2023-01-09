FactoryBot.define do
  factory :post do
    content { 'MyText' }
    picture { 'MyString' }
    kind { 'MyString' }
  end
end
