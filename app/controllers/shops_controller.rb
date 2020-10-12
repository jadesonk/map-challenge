class ShopsController < ApplicationController
  before_action :set_shops, only: [:index]
  before_action :set_icon_url, :set_categories_text, only: [:index, :filter]

  def index
    set_markers
  end

  def filter
    initiate_select
    set_markers
  end

  private

  def initiate_select
    category = params[:select]
    if category.present?
      @shops = Shop.where.not(latitude: nil, longitude: nil).filter_by_category(category)
    end
  end

  def set_shops
    @shops = Shop.where.not(latitude: nil, longitude: nil)
  end

  def set_categories_text
    @categories_text = {
      spa_and_massage: 'Spa and Massage',
      barbershop: 'Hair Salon',
      nails: 'Nails',
      hair_removal: 'Hair Removal',
    }
  end

  def set_icon_url
    @icons = {
      spa_and_massage: 'https://res.cloudinary.com/dbwwrdzej/image/upload/v1602401313/map-challenge/spa_cx8ah3.png',
      barbershop: 'https://res.cloudinary.com/dbwwrdzej/image/upload/v1602401313/map-challenge/hair-dryer_oipsvy.png',
      nails: 'https://res.cloudinary.com/dbwwrdzej/image/upload/v1602401313/map-challenge/hand_u7utpt.png',
      hair_removal: 'https://res.cloudinary.com/dbwwrdzej/image/upload/v1602401722/map-challenge/head-remove_yroqss.png',
      not_set: nil,
    }
  end

  def set_markers
    @markers = @shops.map do |shop|
      {
        lat: shop.latitude,
        lng: shop.longitude,
        infoWindow: {
          content: render_to_string(
            partial: "/shops/map_box",
            locals: {
              shop: shop,
              categories_text: @categories_text,
            }
          )
        },
        icon: @icons[shop.category.to_sym]
      }
    end
  end
end
