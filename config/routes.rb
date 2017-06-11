Rails.application.routes.draw do
  scope 'api', module: 'api' do
    resources :conversations, only: [:index, :create] do
      resources :messages, only: [:index]
    end
  end
end
