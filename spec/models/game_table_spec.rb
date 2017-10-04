# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GameTable, type: :model do
  let(:game_table) { GameTable.new }
  subject { game_table }

  describe 'validation' do
    before do
      subject.valid?
    end

    describe 'game_id' do
      it 'is required' do
        expect(subject.errors[:game_id]).to include "can't be blank"
      end
    end

    describe 'table_id' do
      it 'is required' do
        expect(subject.errors[:table_id]).to include "can't be blank"
      end
    end
  end
end
