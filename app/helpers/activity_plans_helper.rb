module ActivityPlansHelper
  def is_empty? list
    list.each do |l|
      if l.size > 0
        return false
      end
    end
    
    return true
  end
end
