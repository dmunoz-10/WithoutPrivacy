# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'First name validation' do
    it 'must exist' do
      user = build(:user, first_name: nil)
      user.save
      expect(user.errors[:first_name]).to include("can't be blank")
    end
  end

  describe 'Last name validation' do
    it 'must exist' do
      user = build(:user, last_name: nil)
      user.save
      expect(user.errors[:last_name]).to include("can't be blank")
    end
  end

  describe 'Username validation' do
    it 'must exist' do
      user = build(:user, username: nil)
      user.save
      expect(user.errors[:username]).to include("can't be blank")
    end

    it 'must be unique' do
      create(:user, username: 'hola_mundo')
      user = build(:user, username: 'hola_mundo')
      user.save
      expect(user.errors[:username]).to include('has already been taken')
    end

    it 'must be valid' do
      INVALID_USERNAMES = %w[
        invalid-username invalid_username. .invalid_username
        invalid(username invalid)username invalid/username
        invalid\username invalid<username invalid>username
      ].freeze

      user = build(:user, username: INVALID_USERNAMES.sample)
      user.save
      expect(user.errors[:username]).to include('is invalid')
    end
  end

  describe 'Gender validation' do
    it 'must exist' do
      user = build(:user, gender: nil)
      user.save
      expect(user.errors[:gender]).to include("can't be blank")
    end
  end

  describe 'Birth date validation' do
    it 'must exist' do
      user = build(:user, birth_date: nil)
      user.save
      expect(user.errors[:birth_date]).to include("can't be blank")
    end
  end

  describe 'Email validation' do
    it 'must exist' do
      user = build(:user, email: nil)
      user.save
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'must be unique' do
      create(:user, email: 'hola@mundo.com')
      user = build(:user, email: 'hola@mundo.com')
      user.save
      expect(user.errors[:email]).to include('has already been taken')
    end

    it 'must be valid' do
      user = build(:user, email: 'invalid_email')
      user.save
      expect(user.errors[:email]).to include('is invalid')
    end
  end

  describe 'Password validation' do
    it 'must have 6 characters minimum' do
      user = build(:user, password: '123', password_confirmation: '123')
      user.save
      expect(user.errors[:password]).to include('is too short (minimum is 6 characters)')
    end
  end

  describe 'blocked method' do
    let!(:user) { create(:user) }
    let!(:user2) { create(:user) }

    context 'when a user blocks other user' do
      it 'must give true' do
        user.block user2

        expect(user.blocked?(user2)).to eq(true)
      end
    end

    context 'when a user does not block other user' do
      it 'must give false' do
        expect(user.blocked?(user2)).to eq(false)
      end
    end
  end
end
