class ShopsController < ApplicationController
  def index
    @shops = Shop.where.not(latitude: nil, longitude: nil)

    icons = {
      spa_and_massage: 'https://res.cloudinary.com/dbwwrdzej/image/upload/v1602401313/map-challenge/spa_cx8ah3.png',
      barbershop: 'https://res.cloudinary.com/dbwwrdzej/image/upload/v1602401313/map-challenge/hair-dryer_oipsvy.png',
      nails: 'https://res.cloudinary.com/dbwwrdzej/image/upload/v1602401313/map-challenge/hand_u7utpt.png',
      hair_removal: 'https://res.cloudinary.com/dbwwrdzej/image/upload/v1602401722/map-challenge/head-remove_yroqss.png',
      not_set: nil,
    }

    @markers = @shops.map do |shop|
      {
        lat: shop.latitude,
        lng: shop.longitude,
        infoWindow: { content: render_to_string(partial: "/shops/map_box", locals: { shop: shop }) },
        icon: icons[shop.category.to_sym]
      }
    end
  end
end
