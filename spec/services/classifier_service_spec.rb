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

  it 'should trained the data' do
    expect(subject.train(data: valid_data)).to eq(valid_data)
  end

  it 'should not trained the data' do
    expect { subject.train(data: nil) }.to raise_error(ClassifierService::ClassifierServiceError)
  end
end
