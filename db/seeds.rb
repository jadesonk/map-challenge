# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'nokogiri'
require 'csv'

puts "START SEED"

puts "DESTROY ALL SHOPS"
Shop.destroy_all

######## scraping gowabi site for shops and add to CSV ######################
category_url_hash = {
  spa_and_massage: '/en/places/spa-and-massage-salons/in-bangkok-thailand?filter%5Bcategory_id%5D=1',
  barbershop: '/en/places/hair-salons/in-bangkok-thailand?filter%5Bcategory_id%5D=3',
  nails: '/en/places/nail-salons-and-nail-bars/in-bangkok-thailand?filter%5Bcategory_id%5D=4',
  hair_removal: '/en/places/hair-removal-salons/in-bangkok-thailand?filter%5Bcategory_id%5D=5'
}
base_url = 'https://www.gowabi.com'

# category_url_hash.keys.each do |category|
#   category_str = category.to_s
#   puts "STORING '#{category_str}' from Gowabi to CSV file"
#   csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
#   filepath    = "#{__dir__}/csv/#{category_str}.csv"
#   CSV.open(filepath, 'wb', csv_options) do |csv|
#     csv << ['name', 'address', 'category']

#     url = "#{base_url}#{category_url_hash[category]}"
#     html_doc = Nokogiri::HTML(open(url).read)

#     loop do
#       puts "loop"

#       html_doc.search('.right_info').each do |element|
#         name = element.search('h4.mar-none a').text.strip
#         address = element.search('h5.grey_text').text.strip
#         category = category_str

#         csv << [name, address, category]
#       end

#       break if html_doc.search('.next_page').attribute('href').nil?
#       next_page = html_doc.search('.next_page').attribute('href').value

#       url = "#{base_url}#{next_page}"
#       html_doc = Nokogiri::HTML(open(url).read)
#     end
#   end
# end

################ parsing csv to populate db ################################
category_url_hash.keys.each do |category|
  category_str = category.to_s
  puts "PARSING '#{category_str}' CSV to Database"
  csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
  filepath    = "#{__dir__}/csv/#{category_str}.csv"
  CSV.foreach(filepath, csv_options) do |row|
    Shop.create(name: row['name'], address: row['address'], category: row['category'])
    puts "Created shop named -- #{row['name']}"
  end
end

puts "END SEED"
