# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
second_user = User.create!(name:'Bruno', email: 'bruno@email.com', password: '123456', cpf: '47390195665')
user = User.create!(name:'Cus', email: 'cus@leilaodogalpao.com.br', password: '123456', cpf: '52643812328')
first_category = Category.create!(name:"Eletrônicos")
second_category= Category.create!(name:"Ferramentas")
pm = ProductModel.create!(name: 'Tv 32 polegadas', 
                     description: "TV LED SAMSUNG", 
                      weight: 8000, width: 90, 
                       height: 6.3, depth: 6.7, 
                       category: first_category, 
                       image_url: 'TVSamsung32.jpg')

second_pm = ProductModel.create!(name: 'Home Theater JBL', 
                       description: "JBL Soundbar Cinema", 
                       weight: 4200, width: 70, 
                       height: 45, depth: 10, 
                       category: first_category, 
                       image_url: 'JBLhome.jpg')

third_lot = AuctionLot.create!(code: 'ABC123', start_date: 1.day.from_now, limit_date: 3.days.from_now, 
                              value_min: 100, diff_min: 50, status: 'pending', user: user )
auction_lot = AuctionLot.new(code: 'A2CB44', start_date: 2.week.ago , limit_date: 1.weeks.ago, 
                              value_min: 100, diff_min: 50, user: user)
auction_lot.save(validate: false)
second_lot = AuctionLot.new(code: 'A2CB54', start_date: 2.week.ago , limit_date: 1.weeks.ago, 
                           value_min: 100, diff_min: 50, user: user)
second_lot.save(validate: false)

b = Bid.new(user: second_user, auction_lot: second_lot, amount: 120)
b.save(validate:false)

Product.create!(product_model: pm, auction_lot: second_lot)
Product.create!(product_model: second_pm, auction_lot: third_lot)
