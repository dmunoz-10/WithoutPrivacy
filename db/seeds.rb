# frozen_string_literal: true

AdminUser.create!(email: 'admin@example.com',
                  password: 'password',
                  password_confirmation: 'password') if Rails.env.development?

User.create!(first_name: 'Daniel',
             last_name: 'Muñoz',
             username: 'dmunoz10',
             description: "Hi I'm Daniel! I'm a passionate developer fall in love with **Ruby on Rails**",
             gender: :male,
             birth_date: '1999-05-22',
             email: 'daniel@munoz.com',
             password: '123456',
             password_confirmation: '123456')

puts 'Data loaded!'
