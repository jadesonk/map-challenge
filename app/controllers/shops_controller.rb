class ShopsController < ApplicationController
  def index
    @shops = Shop.where.not(latitude: nil, longitude: nil)

    @markers = @shops.map do |shop|
      {
        lat: shop.latitude,
        lng: shop.longitude,
        infoWindow: { content: render_to_string(partial: "/shops/map_box", locals: { shop: shop }) }
      }
    end
  end
end
