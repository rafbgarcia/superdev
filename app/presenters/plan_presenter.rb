class PlanPresenter < BasePresenter

  def title
    case @object.identifier
    when 'superdev_academy_pioneiros'
      'Pioneiros'
    when 'partiu_codar'
      %{ Campanha <strong>#PartiuCodar</strong> }.html_safe
    end
  end

  def price
    number_to_currency @object.prices.first['value_cents'] / 100.0
  end

  def description
    case @object.identifier
    when 'superdev_academy_pioneiros'
      %{
        <p class="mb-0 text-center">
          <u>Quase <strong>50% OFF</strong></u> na mensalidade.
          <br>
          De <del>R$ 65,00</del> por apenas #{self.price}.
        </p>
      }.html_safe

    when 'partiu_codar'
      %{
        <p class="mb-0">
          Preparado para se juntar à tribo que mais ama programação no Brasil?
        </p>
      }.html_safe
    end
  end

end
