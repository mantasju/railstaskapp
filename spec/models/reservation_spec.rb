# frozen_string_literal: true

describe Reservation do
  context 'creation' do
    it 'should have the correct end time upon creation' do
      time = Time.new

      reservation = Reservation.new(
        start_time: time,
        end_time: time + 1 * 60 * 60
      )

      expect(reservation.end_time.to_i).to eq((time + 1 * 60 * 60).to_i)
    end
  end

  context 'time' do
    it 'should be an instance of time' do
      time = Time.new

      reservation = Reservation.new(
        start_time: time,
        end_time: time + 1 * 60 * 60
      )

      expect(reservation.start_time).to be_a(Time)
    end
  end

  context 'equals' do
    it 'should be equal with same start time and length' do
      time = Time.new(2002)

      r1 = Reservation.new(
        start_time: time,
        end_time: time + 1 * 60 * 60
      )
      r2 = Reservation.new(
        start_time: time,
        end_time: time + 1 * 60 * 60
      )

      expect(r1).to eq r2
    end

    it 'should not equal if times are equal but lengths are different' do
      time = Time.new

      r1 = Reservation.new(
        start_time: time,
        end_time: time + 1 * 60 * 60
      )
      r2 = Reservation.new(
        start_time: time,
        end_time: time + 2 * 60 * 60
      )

      expect(r1).not_to eq r2
    end

    it 'should not equal if times are not equal but lengths are equal' do
      time = Time.new

      r1 = Reservation.new(
        start_time: time,
        end_time: time + 2 * 60 * 60
      )
      r2 = Reservation.new(
        start_time: time + 1 * 60,
        end_time: time + 3 * 60 * 60
      )

      expect(r1).not_to eq r2
    end

    it 'should not equal if start times are different but end times are same' do
      time = Time.new

      r1 = Reservation.new(
        start_time: time,
        end_time: 2
      )
      r2 = Reservation.new(
        start_time: time + 1 * 60 * 60,
        end_time: 1
      )

      expect(r1).not_to eq r2
    end

    it 'should not equal if both times and lengths are different' do
      time = Time.new

      r1 = Reservation.new(start_time: time, end_time: 9)
      r2 = Reservation.new(start_time: time + 1 * 60, end_time: 2)

      expect(r1).not_to eq r2
    end
  end
end
