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
          * Vagas 90% esgotadas.
          <br>Inscrições podem fechar a qualquer momento.
          <br><br>
          <u><strong>54% OFF</strong></u> nas mensalidades.
          <br>
          De <del>R$ 65,00</del> por apenas <%= @plan.price %>.
        </p>
      }.html_safe

    when 'partiu_codar'
      %{
        <p class="mb-0">
          Junte-se a dezenas de aprendizes nesta iniciativa de incentivo à Programação.
          <br><br>
          Ganhe <u><strong>31% OFF</strong></u> nas mensalidades.
          <br>
          De <del>R$ 65,00</del> por apenas R$ 45,00.
        </p>
      }.html_safe
    end
  end

end
