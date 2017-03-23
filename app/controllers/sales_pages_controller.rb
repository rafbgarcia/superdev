class SalesPagesController < ApplicationController

  def index
    @video_id =
      case params[:video_id]
      when '2'
        'h8xy9wLYWCs'
      when '3'
        'pmRXRNmzMxw'
      else
        'pDbIEAy-KnM'
      end
  end

end
