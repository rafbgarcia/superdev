class SalesPagesController < ApplicationController

  def index
    @video_id =
      case params[:video_id]
      when '2'
        ''
      when '3'
        ''
      else
        'pDbIEAy-KnM'
      end
  end

end
