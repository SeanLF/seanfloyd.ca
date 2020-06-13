# frozen_string_literal: true

describe DateHelper do
  include DateHelper
  let(:date_string) { '2020-06-01' }
  let(:date) { Date.parse(date_string) }
  let(:now) { 'now' }
  let(:today) { Date.today }

  describe '#parse_date' do
    context 'when date is today' do
      subject { parse_date(now) }

      it { is_expected.to eq(today) }
    end

    context 'regular date' do
      subject { parse_date(date_string) }

      it { is_expected.to eq(date) }
    end
  end

  describe '#how_long' do
    context 'start date after end date' do
      subject { how_long(date, '2019-06-01') }

      it { is_expected.to eq([-1, 0]) }
    end

    context 'for a difference of less than 1 month' do
      subject { how_long('2020-05-20', date) }

      it { is_expected.to eq([0, 0]) }
    end

    context 'for a difference of 5 months' do
      subject { how_long('2020-01-01', date) }

      it { is_expected.to eq([0, 5]) }
    end

    context 'for a difference of 1 year' do
      subject { how_long('2019-06-01', date) }

      it { is_expected.to eq([1, 0]) }
    end

    context 'for a difference of 5 years, 3 months' do
      subject { how_long('2015-04-03', date) }

      it { is_expected.to eq([5, 3]) }
    end
  end

  describe '#format_date_ymd' do
    subject { format_date_ymd(date) }

    it { is_expected.to eq(date_string) }
  end
end
