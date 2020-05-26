Rails.application.routes.draw do
  namespace :v1 do
    post 'github', to: "github_webhooks#create"
  end
end
