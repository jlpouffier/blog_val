RailsAdmin.config do |config|

  def markdown(text)
    options = [:hard_wrap, :filter_html, :no_intra_emphasis, :autolink, :underline, :highlight, :quote, :tables, :lax_spacing]
    Markdown.new(text, *options).to_html.html_safe
  end

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  config.model 'Category' do
    list do 
      field :title
    end

    edit do 
      field :title
      field :photo
      field :description
    end
  end

  config.model 'Recipe' do
    list do 
      field :title
    end

    edit do
      field :title
      field :photo
      field :story 
      field :instructions
      field :ingredients
      field :tools
      field :tips
      field :complexity
      field :preparation_time
      field :waiting_time
      field :baking_time
      field :vegan
      field :categories
    end
  end

  ## == CancanCan ==
  # config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.included_models = ["Category", "Recipe"]

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
