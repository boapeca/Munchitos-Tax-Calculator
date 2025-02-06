Rails.application.routes.draw do
  get "/calculate_tax", to: "taxes#calculate"
end
