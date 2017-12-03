# frozen_string_literal: true

require File.join(File.dirname(__FILE__), '..', 'rails_helper')

describe Court do
  # You have to pass start time as first argument and end time as second
  RSpec::Matchers.define :contain_reservation_time do |*expected|
    match do |actual|
      actual.each do |res|
        start = expected[0]
        end_time = expected[1]
        first_val = (res.start_time.to_i == start.to_i)
        second_val = (res.end_time.to_i == end_time.to_i)
        return true if first_val && second_val
      end
      return false
    end
  end

  before(:each) do
    allow(LoginHelper)
      .to receive(:logged_in_user).and_return(create(:test_user))
    @court = create(:court)
    time = Time.new - 5 * 60 * 60
    @court.add_reservation(time, time + 1 * 60 * 60)
  end

  context 'creation' do
    it 'should have the creating user as the creator after creation' do
      expect(@court.user).to eq(LoginHelper.logged_in_user)
    end
  end

  context 'equals' do
    it 'should fail if only x\'es are equal' do
      court1 = Court.new(
        longitude: 1,
        latidute: 1
      )
      court2 = Court.new(
        longitude: 1,
        latidute: 2
      )

      expect(court1 == court2).to be false
    end

    it 'should fail if only y\'es are equal' do
      court1 = Court.new(
        longitude: 1,
        latidute: 1
      )
      court2 = Court.new(
        longitude: 2,
        latidute: 1
      )

      expect(court1 == court2).to be false
    end

    it 'should succeed if x and y are both equal' do
      court1 = Court.new(
        longitude: 1,
        latidute: 1
      )
      court2 = Court.new(
        longitude: 1,
        latidute: 1
      )

      expect(court1 == court2).to be true
    end
  end

  context 'reservations' do
    it 'should succesfully create a reservation' do
      time = Time.new

      @court.add_reservation(time, time + 1 * 60 * 60)

      expect(@court.reservations.to_a)
        .to contain_reservation_time(time, time + 1 * 60 * 60)
    end

    it 'should succesfully remove a reservation' do
      time = Time.new + 24 * 60 * 60

      @court.add_reservation(time, time + 1 * 60 * 60)

      @court.remove_reservation(time)

      expect(@court.reservations.to_a)
        .to_not contain_reservation_time(time, time + 1 * 60 * 60)
    end
  end
end
