class Alternative < ApplicationRecord
  belongs_to :choice_question

  def as_json
    {
      id: id,
      explanation: explanation,
      correct: correct,
    }
  end
end
