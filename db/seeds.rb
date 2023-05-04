# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.create!(name:'Bruno', email: 'bruno@email.com', password: '123456', cpf: '47390195665')
User.create!(name:'Bruno Guimarães', email: 'bruno@leilaodogalpao.com.br', password: '123456', cpf: '63430323711')
