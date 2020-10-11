class ShopsController < ApplicationController
  def index
    @shops = Shop.where.not(latitude: nil, longitude: nil)

    @markers = @shops.map do |shop|
      {
        lat: shop.latitude,
        lng: shop.longitude
      }
    end
  end
end
