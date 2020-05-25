Rails.application.routes.draw do
  post 'githook', to "git_webhook#create"
end
