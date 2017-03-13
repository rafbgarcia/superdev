module AnswersHelper
  def answer_icon_for(user, item)
    answer = Answer.for(user, item)

    return if answer.blank?

    if answer.correct?
      '<small class="label label-success"><i class="fa fa-check"></i> Acertou</small>'
    else
      '<small class="label label-danger"><i class="fa fa-times"></i> Errou</small>'
    end.html_safe
  end
end
