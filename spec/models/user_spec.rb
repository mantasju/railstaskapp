# frozen_string_literal: true

require File.join(File.dirname(__FILE__), '..', 'rails_helper')

describe User do
  context 'creation' do
    it 'should not allow creation with a bad email' do
      user = build(:invalid_email_user)

      user.valid?

      expect(user.errors[:email].first).to eq 'Email must be a string'
    end

    it 'should have the correct age after creation' do
      user = build(:user)

      expect(user.age).to eq 15
    end

    it 'should have the correct email after creation' do
      user = build(:user)

      expect(user.email).to eq 'a@a.a'
    end

    it 'should have the correct username after creation' do
      user = build(:user)

      expect(user.username).to eq 'asdasd'
    end

    it 'should encrypt the password during creation' do
      expect(build(:user).password)
        .to eq Digest::MD5.hexdigest('asdasd')
    end
  end
end
