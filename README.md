# Cooking with Ruby

## Features
- multilingual app (german, english) - ok
- user administration: -ok
  - login - ok (omniauth - ok, 2-factor-authentication)
  - admin area - ok
- collection of recipes:
  - different search options selectable -ok
    (type in wantet ingredients, name of meal)
  - different sorting of results (shifted)
    (rating, preparation time, ...)
  - insert new recipe - ok
    (description, ingredients, nutrients, picture(s))
  - valuation function for recipe -ok
- Food-planner - ok
  - meals for the next week - ok
  - activities today - ok
  - show required & consumed nutrients (if the user wants it) - ok
- Generate shopping list from planner - ok
  - export: pdf - ok
- create your own cookbook -ok
  - own recipes - ok
  - favorites - ok
- Sharing recipes with others (shifted)

## Optional Features
- Generated shopping list as email
- photo Gallery
- Comments to exchange tips - ok
  - Author can pin good messages so they will show at the top
- Following of users
  - Friends
  - Cooks you like
- History
- Statistics

- Parsing of nutrition values from known sites.

##Used Gems

- rails-i18n
- Twitter Bootstrap
- nested form
- Rails Bootstrap Forms
- Prawn
- Devise
- Devise-Two-Factor
- Devise-i18n
- omniauth
- omniauth-twitter
- omniauth-google-oauth2
- omniauth-github
- fuzzily

- cancancan

- Better Errors
- Binding of Caller
