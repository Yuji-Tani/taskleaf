# == Route Map
#
#                    Prefix Verb   URI Pattern                                                                              Controller#Action
#                     login GET    /login(.:format)                                                                         sessions#new
#                           POST   /login(.:format)                                                                         sessions#create
#                    logout DELETE /logout(.:format)                                                                        sessions#destroy
#               admin_users GET    /admin/users(.:format)                                                                   admin/users#index
#                           POST   /admin/users(.:format)                                                                   admin/users#create
#            new_admin_user GET    /admin/users/new(.:format)                                                               admin/users#new
#           edit_admin_user GET    /admin/users/:id/edit(.:format)                                                          admin/users#edit
#                admin_user GET    /admin/users/:id(.:format)                                                               admin/users#show
#                           PATCH  /admin/users/:id(.:format)                                                               admin/users#update
#                           PUT    /admin/users/:id(.:format)                                                               admin/users#update
#                           DELETE /admin/users/:id(.:format)                                                               admin/users#destroy
#                      root GET    /                                                                                        tasks#index
#          confirm_new_task POST   /tasks/new/confirm(.:format)                                                             tasks#confirm_new
#                     tasks GET    /tasks(.:format)                                                                         tasks#index
#                           POST   /tasks(.:format)                                                                         tasks#create
#                  new_task GET    /tasks/new(.:format)                                                                     tasks#new
#                 edit_task GET    /tasks/:id/edit(.:format)                                                                tasks#edit
#                      task GET    /tasks/:id(.:format)                                                                     tasks#show
#                           PATCH  /tasks/:id(.:format)                                                                     tasks#update
#                           PUT    /tasks/:id(.:format)                                                                     tasks#update
#                           DELETE /tasks/:id(.:format)                                                                     tasks#destroy
#        rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
# rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#        rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
# update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#      rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create

Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  namespace :admin do
    resources :users
  end

  root to: 'tasks#index'
  resources :tasks do
    post :confirm, action: :confirm_new, on: :new
    post :import, on: :collection
  end
end
