Rails.application.routes.draw do
  namespace :v1 do
    post 'githook', to: "git_webhook#create"
  end
end
