# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ClassifierService' do
  let(:valid_data) do
    [
      {
        category_name: 'Good',
        values: ['Make time for exercise.', 'Drink at least eight glasses of water a day.', 'Do bodywork.',
                 'Assign priorities to your tasks.', 'Celebrate small victories.']
      },
      {
        category_name: 'Bad',
        values: ['Being Too Hard on Yourself', 'Leaving Things to the Last Minute', 'Focusing on the Negatives',
                 'Blaming', 'Sour Grapes']
      }
    ]
  end

  let(:subject) { ClassifierService.new }

  describe '#classify' do
    it 'should trained the data' do
      expect(subject.train(data: valid_data)).to eq(valid_data)
    end

    it 'should not trained the data' do
      expect { subject.train(data: nil) }.to raise_error(ClassifierService::ClassifierServiceError)
    end
  end

  describe '#check' do
    before(:each) do
      subject.train(data: valid_data)
    end

    it 'should return Good clasification' do
      expect(subject.check(query: 'exercise')).to eq('Good')
    end

    it 'should return Bad clasification' do
      expect(subject.check(query: 'Leaving')).to eq('Bad')
    end

    it 'should raise ClassifierNotFoundError error' do
      expect { subject.check(query: 'test') }.to raise_error(ClassifierService::ClassifierNotFoundError)
    end
  end
end
