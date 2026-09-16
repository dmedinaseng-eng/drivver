Rails.application.routes.draw do
 root "landing#sellers"
 get "buyers", to: "landing#buyers"
 
end
