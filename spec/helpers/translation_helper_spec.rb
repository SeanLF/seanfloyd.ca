# frozen_string_literal: true

describe TranslationHelper do
  include TranslationHelper
  R18n.set('en')
  let(:date_string) { '2020-06-01' }
  let(:humanized_date_string) { 'Jun 2020' }
  let(:date) { Date.parse(date_string) }
  let(:now) { 'now' }
  let(:today) { Date.today }

  describe '#humanize_date' do
    context 'regular date' do
      subject { humanize_date(date) }

      it { is_expected.to(eq(humanized_date_string)) }
    end

    context 'today' do
      subject { humanize_date(today) }

      it { is_expected.to(eq(now)) }
    end
  end

  describe '#format_date_mdy_ordinalize' do
    context 'regular date' do
      subject { format_date_mdy_ordinalize(date) }

      it { is_expected.to(eq('June 1st, 2020')) }
    end
  end
end
