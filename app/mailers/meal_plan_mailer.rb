class MealPlanMailer < ActionMailer::Base
  default from: "from@cookingwithruby.com"
  
  def meal_week_plan user, pdf
    @user = user
    
    attachments['plan for the week.pdf'] = {
      mime_type: 'application/pdf',
      content: pdf
    }
    
    mail to: @user.email, subject: t( 'mail.meal_plans_for_week' )
  end
end
