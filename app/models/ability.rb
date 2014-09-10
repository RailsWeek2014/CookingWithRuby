class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in @user here. For example:
    #
    #   @user ||= User.new # guest @user (not logged in)
    #   if @user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the @user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the @user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the @user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
    
    @user = user || User.new
    
    unless @user.new_record?
      if apply_role? 'u'
        can [:list, :show], Recipe, range: ['public', 'registrated']
        can [:list, :show], Recipe, user_id: @user.id
        can :create, Recipe
        can :update, Recipe, user_id: @user.id
        can :destroy, Recipe, user_id: @user.id
        can :specific_list, Recipe
        
        can :manage, Category
        
        can :manage, Comment
        cannot :destroy, Comment
        can :destroy, Comment, user_id: @user.id
        
        cannot :edit, Comment
        can :edit, Comment, user_id: @user.id
        
        can :create, User, id: @user.id
        can :update, User, id: @user.id
        can :edit, User, id: @user.id
        can :read, User, id: @user.id
        can :destroy, User, id: @user.id
        
        can :manage, Cookbook, user_id: @user.id
        
        can :manage, Ingredient
        cannot :destroy, Ingredient
        
        can :manage, MealPlan, user_id: @user.id
        
        can :manage, Unit
        
        can :manage, ActivityPlan, user_id: @user.id

        can :manage, Activity
      end
      if apply_role? 'm'
        can :grant_permissions, User
        can :grant_user, User
      end
      if apply_role? 'a'
        can :grant_moderator, User
      end
      
    else
      can :list, Recipe, range: 'public'
      can :show, Recipe, range: 'public'
      
      cannot :create, Recipe
      
      can :create, User
    end
  end
  
  private
    ROLES = ['u', 'm', 'a']
  
    def apply_role? role
      ROLES.index( role ) <= ROLES.index( @user.role )
    end
end
