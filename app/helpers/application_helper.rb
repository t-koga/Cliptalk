module ApplicationHelper
  def nl2br(str)
    h(str).gsub(/\R/, "<br>")
  end

  def index_display(models, param_name = "page", per = nil)
    page = models.page(params[param_name])
    page = page.per(per) if per
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
      "#{page.offset_value+1} - #{(page.current_page-1) * page.limit_value + page.size} / #{models.total_count}#{unit}中"
    end
  end
end
