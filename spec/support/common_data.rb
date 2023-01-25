# frozen_string_literal: true

shared_examples 'common data' do
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

  let(:good) { 'Good' }
  let(:bad) { 'Bad' }
  let(:exercise) { 'exercise' }
  let(:leaving) { 'leaving' }
  let(:test) { 'test' }
  let(:are) { 'are' }
end
