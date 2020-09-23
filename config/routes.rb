Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post :urls, controller: 'links', path: 'urls'
      get :short_url, controller: 'links', path: 'links/:name/short_url'
      get :stats, controller: 'links', path: 'links/:name/stats'
    end
  end
end
