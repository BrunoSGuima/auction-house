# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user = User.create!(name:'Bruno', email: 'bruno@email.com', password: '123456', cpf: '47390195665')
second_user = User.create!(name:'Usuário', email: 'user@email.com', password: 'password', cpf: '14831082287')
third_user = User.create!(name:'Usuário_dois', email: 'user2@email.com', password: 'password', cpf: '54688888740')
fourth_user = User.create!(name:'Usuário_tres', email: 'user3@email.com', password: 'password', cpf: '48981652813')
fifth_user= User.create!(name:'Usuário_quatro', email: 'user4@email.com', password: 'password', cpf: '77931669657')
User.create!(name:'Usuário_cinco', email: 'user5@email.com', password: 'password', cpf: '05896727542')
User.create!(name:'Usuário_seis', email: 'user6@email.com', password: 'password', cpf: '67767586707')
User.create!(name:'Usuário_sete', email: 'user7@email.com', password: 'password', cpf: '49347538264')
User.create!(name:'Usuário_oito', email: 'user8@email.com', password: 'password', cpf: '31311286071')
User.create!(name:'Usuário_nove', email: 'user9@email.com', password: 'password', cpf: '41058135368')
User.create!(name:'Usuário_dez', email: 'user10@email.com', password: 'password', cpf: '60118812890')
admin = User.create!(name:'Admin', email: 'admin@leilaodogalpao.com.br', password: 'password', cpf: '52643812328')
second_admin = User.create!(name:'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password', cpf: '24811717058')
third_admin = User.create!(name:'Bruno', email: 'bruno@leilaodogalpao.com.br', password: '123456', cpf: '78383276796')
first_category = Category.create!(name:"Eletrônicos")
second_category= Category.create!(name:"Ferramentas")
third_category= Category.create!(name:"Hobbies")
fourth_category= Category.create!(name:"Pesca")
fifth_category= Category.create!(name:"Esportes")
pm = ProductModel.create!(name: 'Tv 32 polegadas', 
                     description: "A Smart TV LED 32 Polegadas Samsung, equipada com a tecnologia de Business TV.", 
                      weight: 5800, width: 880, 
                       height: 50, depth: 15, 
                       category: first_category) 
pm.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'TVSamsung32.jpg')), 
                       filename: 'TVSamsung32.jpg', content_type: 'image/jpg')

second_pm = ProductModel.create!(name: 'Home Theater JBL', 
                       description: "A soundbar JBL Bar 2.1 Deep Bass produz uma sonoridade de cinema, que transformará a sua sala de estar.", 
                       weight: 5670, width: 965, 
                       height: 58, depth: 58, 
                       category: first_category) 
second_pm.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'JBLhome.jpg')), 
                       filename: 'JBLhome.jpg', content_type: 'image/jpg')

third_pm = ProductModel.create!(name: 'Caneca Star Wars', 
                      description: "Uma caneca do Star Wars para o João", 
                      weight: 300, width: 12, 
                        height: 16, depth: 11, 
                        category: third_category)
third_pm.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'caneca_starwars.jpg')), 
                        filename: 'caneca_starwars.jpg', content_type: 'image/jpg')

fourth_pm = ProductModel.create!(name: 'Caixa de Ferramentas', 
                          description: "Jogo de Ferramentas Profissional 102 Peças com Maleta foi produzido em material de alta resistência, 
                                          proporcionando qualidade e durabilidade. ", 
                          weight: 4000, width: 320, 
                            height: 16, depth: 150, 
                            category: second_category)
fourth_pm.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'ferramentas.jpg')), 
                            filename: 'ferramentas.jpg', content_type: 'image/jpg')

fifth_pm = ProductModel.create!(name: 'MacBook Pro', 
                          description: "O Notebook Apple Macbook Pro MWP52BZ Intel Core i5 13,3 16GB SSD 1 TB 
                          Mac OS Leitor Biométrico, da Apple, conta com o sistema operacional Mac OS.", 
                          weight: 1400, width: 214, 
                            height: 15, depth: 210, 
                            category: first_category)
fifth_pm.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'MacBook_pro.jpg')), 
                            filename: 'MacBook_pro.jpg', content_type: 'image/jpg')

sixth_pm = ProductModel.create!(name: 'Bicicleta', 
                          description: "Bicicleta Mtb Mountain Bike Lazer Passeio Giant Atx", 
                          weight: 1000, width: 21, 
                            height: 1550, depth: 21, 
                            category: fifth_category)
sixth_pm.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'bicicleta.jpg')), 
                            filename: 'bicicleta.jpg', content_type: 'image/jpg')
seventh_pm = ProductModel.create!(name: 'Vara de pesca', 
                          description: "Uma maravilhosa vara de pesca para pescar os maiores tambaquis.", 
                          weight: 200, width: 25, 
                            height: 1650, depth: 22, 
                            category: fourth_category)
seventh_pm.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'vara_de_pesca.jpg')), 
                            filename: 'vara_de_pesca.jpg', content_type: 'image/jpg')


auction_lot = AuctionLot.new(code: 'A2CB44', start_date: 2.week.ago , limit_date: 1.weeks.ago, 
                              value_min: 100, diff_min: 50, user: second_admin)
auction_lot.save(validate: false)

second_lot = AuctionLot.new(code: 'A2CB54', start_date: 2.week.ago , limit_date: 1.weeks.ago, 
                           value_min: 100, diff_min: 50, user: second_admin)
second_lot.save(validate: false)

third_lot = AuctionLot.create!(code: 'ABC123', start_date: 1.day.from_now, limit_date: 3.days.from_now, 
  value_min: 100, diff_min: 50, status: 'pending', user: second_admin )
fourth_lot = AuctionLot.create!(code: 'STW123', start_date: 1.day.from_now, limit_date: 3.days.from_now, 
  value_min: 100, diff_min: 50, status: 'pending', user: second_admin )
fifth_lot = AuctionLot.create!(code: 'AJB007', start_date: 1.day.from_now, limit_date: 3.days.from_now, 
    value_min: 100, diff_min: 50, status: 'pending', user: second_admin )
sixth_lot = AuctionLot.create!(code: 'OKA808', start_date: 1.day.from_now, limit_date: 3.days.from_now, 
      value_min: 100, diff_min: 50, status: 'approved', user: second_admin )
seventh_lot = AuctionLot.create!(code: 'OKO708', start_date: Date.today, limit_date: 2.days.from_now, 
        value_min: 100, diff_min: 50, status: 'approved', user: second_admin )
eigth_lot = AuctionLot.create!(code: 'AKO708', start_date: Date.today, limit_date: 3.days.from_now, 
          value_min: 100, diff_min: 50, status: 'approved', user: second_admin )
ninth_lot = AuctionLot.create!(code: 'IKA708', start_date: Date.today, limit_date: 3.days.from_now, 
            value_min: 100, diff_min: 50, status: 'approved', user: third_admin )

tenth_lot = AuctionLot.new(code: 'EKA708', start_date: 2.week.ago, limit_date: 1.weeks.ago, 
            value_min: 100, diff_min: 50, status: 'closed', user: admin )
tenth_lot.save(validate: false)
  

b = Bid.new(user: second_user, auction_lot: second_lot, amount: 120)
b.save(validate:false)

c = Bid.new(user: second_user, auction_lot: tenth_lot, amount: 120)
c.save(validate:false)

Product.create!(product_model: pm, auction_lot: second_lot)
Product.create!(product_model: second_pm, auction_lot: third_lot)
Product.create!(product_model: third_pm, auction_lot: third_lot)
Product.create!(product_model: fourth_pm, auction_lot: third_lot)
Product.create!(product_model: sixth_pm, auction_lot: sixth_lot)
Product.create!(product_model: fourth_pm, auction_lot: tenth_lot)
Product.create!(product_model: third_pm, auction_lot: sixth_lot)
Product.create!(product_model: second_pm, auction_lot: seventh_lot)
Product.create!(product_model: fourth_pm, auction_lot: seventh_lot)
Product.create!(product_model: third_pm, auction_lot: seventh_lot)
Product.create!(product_model: fourth_pm, auction_lot: eigth_lot)
Product.create!(product_model: fifth_pm, auction_lot: ninth_lot)
Product.create!(product_model: seventh_pm, auction_lot: ninth_lot)
Product.create!(product_model: sixth_pm, auction_lot: fourth_lot)

Question.create!(user: second_user, auction_lot: seventh_lot, question_text: "Uma dúvida qualquer" )
Question.create!(user: third_user, auction_lot: eigth_lot, question_text: "Uma dúvida qualquer sobre isso" )
Question.create!(user: fourth_user, auction_lot: ninth_lot, question_text: "Uma dúvida qualquer sobre aquilo" )

FavoriteAuctionLot.create!(user: second_user, auction_lot: fifth_lot)
FavoriteAuctionLot.create!(user: second_user, auction_lot: sixth_lot)
FavoriteAuctionLot.create!(user: second_user, auction_lot: seventh_lot)

BlockedCpf.create!(cpf: "14632459127")
BlockedCpf.create!(cpf: "11538587629")
BlockedCpf.create!(cpf: "90390652253")
BlockedCpf.create!(cpf: "67767586707")




