module UserHelper
  
  # Harris-Benedict-formula with brocca index adaptation
  def getBasalMetabolism
    weight = current_user.weight
    height = current_user.height
    age = Date.today.year - birth_date.year
    if(weight == nil || height == nil)
      return nil
    else
      if(current_user.sex == "m")
        return 14.24 * weight + 64.06 * height - 28.47 * age - 4023.55
      else
        return 10.05 * weight + 37.68 * height - 19.68 * age - 272.14
      end
    end
  end
  
end