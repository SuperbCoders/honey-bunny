module PostsHelper
  def grid_class(index)
    remainder = index % 3
    case remainder
    when 0
      'col-1 col-md-1'
    when 1
      'col-2-3 col-md-1'
    when 2
      'col-1-3 col-md-1'
    end
  end
end
