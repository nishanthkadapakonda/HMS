Rails.application.routes.draw do
  get 'bookings/book'
  post 'bookings/createBooking'
  get 'bookings/createBooking'
  get 'main/index'

  resources :slots
  get 'errors/accesserror'
  get 'doctors/new'
  get 'doctors/createslot'
  get 'home/index'
  get 'home/mybookings'
  post 'home/index'


 root 'main#index' 
 get 'slots/index'

  get 'bookings/index'
  get 'doctors/show'
  get 'doctors/index'
  get 'doctors/create'
  post 'doctors/create'
  
  resources :hospitals
  devise_for :users, :controllers => {registrations: 'users/registrations',sessions: 'users/sessions'}

  devise_scope :user do
    get 'users/sign_out' => 'users/sessions#destroy'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
