class Answer < ApplicationRecord
  belongs_to :item
  belongs_to :user
  belongs_to :alternative

  # Scopes
    scope :correct, -> { includes(:item, :alternative).where(correct: true) }


  class << self

    def for(user, item)
      where(user: user, item: item).first
    end

    def choice_question(user:, alternative_id:, item_id:)
      answer = Answer.new(
        user: user,
        item_id: item_id,
        alternative_id: alternative_id,
      )
      answer.correct = answer.send :user_answered_correctly?

      answer.save!
      answer
    rescue ActiveRecord::RecordNotFound
      raise Superdev::Error.new "#{user.first_name}, você precisa selecionar uma alternativa para responder", :not_found
    rescue ActiveRecord::RecordNotUnique
      raise Superdev::Error.new "#{user.first_name}, você já respondeu esta questão, não pode mais mudar :)"
    rescue ActiveRecord::StatementInvalid
      raise Superdev::Error.new "#{user.first_name}, deu algo errado. Por favor tenta essa mesma ação novamente e, caso o erro persista, peço que por favor entre em contato informando o erro. Obrigado!"
    end

  end

private

  def user_answered_correctly?
    if item.choice_question?
      alternative.correct?
    end
  end

end
