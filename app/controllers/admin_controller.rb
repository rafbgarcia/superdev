class AdminController < ApplicationController
  ActionController::Parameters.permit_all_parameters = true

  http_basic_authenticate_with name: "rafaloco", password: "el secret es la muerte!123."

  def index
  end

end
