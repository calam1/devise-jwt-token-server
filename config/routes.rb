Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # scope :api, defaults: { format: :json } do
  #   devise_for :users, controllers: { sessions: :sessions },
  #              path_names: { sign_in: :login }
  # end


  scope :api, defaults: { format: :json } do
    devise_for :users, controllers: { sessions: 'sessions' },
               path_names: {
                   sign_in: 'login',
                   sign_out: 'logout',
                   registration: 'signup'
               }
    end
end
