# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Table, type: :model do
  let(:table) { Table.new }
  subject { table }

  it { is_expected.to have_and_belong_to_many :games }

  describe 'validation' do
    before do
      subject.valid?
    end

    describe 'name' do
      it 'cannot be blank' do
        expect(subject.errors[:name]).to include "can't be blank"
      end
    end
  end
end
