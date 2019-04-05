module ApplicationHelper
  def nl2br(str)
    h(str).gsub(/\R/, "<br>")
  end

  def index_display(models)
    unit =
      case models
      when @rooms
        "部屋"
      when @users
        "人"
      when @articles
        "件"
      else
        "件"
      end
    unless models.total_count == 0
      "#{models.page(params[:page]).offset_value + 1} - #{models.total_count - models.page(params[:page]).offset_value} / #{models.total_count}#{unit}中"
    end
  end
end
