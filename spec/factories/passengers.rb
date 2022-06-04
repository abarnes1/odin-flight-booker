FactoryBot.define do
  factory :passenger do
    transient do
      booking { nil }
    end

    booking_id { booking&.id }

    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name

    name { "#{first_name} #{last_name}" }
    email { "#{first_name[0]}#{last_name}@#{Faker::Internet.domain_name}".downcase }

    # Reset local variables between building passengers
    after(:build) do
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
    end
  end
end
