class AnswersController < ApplicationController

  def create
    answer = Answer.choice_question(
      user: current_user,
      alternative_id: params[:alternative_id],
      item_id: params[:item_id],
    )

    user_level = UserLevel.new(current_user, answer).compute!

    render json: {
      alternative: answer.alternative.as_json,
      user: user_level.as_json,
    }
  rescue Superdev::Error => e
    render json: e.response_data, status: e.status
  end

end
