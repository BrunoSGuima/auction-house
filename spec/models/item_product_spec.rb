require 'rails_helper'

RSpec.describe ItemProduct, type: :model do
  describe "gera um número de série" do
    it "ao criar um ItemProduct" do
    category = Category.create!(name: "Eletrônicos")
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    pm = ProductModel.create!(name: 'Tv 32', description: 'TV Samsung de 32 polegadas', weight: 8000, width: 70, height: 45, depth: 10, 
                              category: category)
    al = AuctionLot.create!(code: 'A1CB34', start_date: '20/06/2024' , limit_date: '29/06/2024', 
                          value_min: 100, diff_min: 50, status: 'pending', user: user)
    auction_item = AuctionItem.create(auction_lot: al, product_model: pm, quantity: 10)

    item_product = ItemProduct.create!(auction_lot: al, product_model: pm, auction_item: auction_item)
      
      expect(item_product.serial_number.length).to eq 10
    end

    it "e não é modificado" do
    category = Category.create!(name: "Eletrônicos")
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    pm = ProductModel.create!(name: 'Tv 32', description: 'TV Samsung de 32 polegadas', weight: 8000, width: 70, height: 45, depth: 10, 
                              category: category)
    al = AuctionLot.create!(code: 'A1CB34', start_date: '20/06/2024' , limit_date: '29/06/2024', 
                          value_min: 100, diff_min: 50, status: 'pending', user: user)
    second_al = AuctionLot.create!(code: 'A3CB55', start_date: '20/06/2024' , limit_date: '29/06/2024', 
                            value_min: 100, diff_min: 50, status: 'pending', user: user)
    auction_item = AuctionItem.create(auction_lot: al, product_model: pm, quantity: 10)

    item_product = ItemProduct.create!(auction_lot: al, product_model: pm, auction_item: auction_item)
    original_serial_number = item_product.serial_number

    item_product.update!(auction_lot: second_al)

    expect(item_product.serial_number).to eq(original_serial_number)
    end 
  end

  # describe "#available?" do

  #   it "true se não tiver destino" do
  #     user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')
  #     warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'SDU', city:'São Paulo', area: 60_000, cep: '20000-000', 
  #                                  description:'Galpão do aeroporto de SP', address: 'Avenida Atlantica, 10')
  #     supplier = Supplier.create!(corporate_name: 'Meta', brand_name: 'Facebook', registration_number:'12645-412', 
  #                               full_address: 'Rua do Facebook, 09', city: 'São Paulo', 
  #                                  state:'SP', email: 'sac.facebook@facebook.com')
  #     order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, status: :delivered, estimated_delivery_date: 1.week.from_now)
  #     product_a = ProductModel.create!(name: 'Cadeira Gamer', weight: 5, width: 70, height: 100, depth: 75, supplier: supplier, sku: 'CAD-GAMER-1324')
  #     stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product_a)

  #     expect(stock_product.available?).to eq true
      
  #   end

  #   it "false se tiver destino" do
  #     user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')
  #     warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'SDU', city:'São Paulo', area: 60_000, cep: '20000-000', 
  #                                  description:'Galpão do aeroporto de SP', address: 'Avenida Atlantica, 10')
  #     supplier = Supplier.create!(corporate_name: 'Meta', brand_name: 'Facebook', registration_number:'12645-412', 
  #                               full_address: 'Rua do Facebook, 09', city: 'São Paulo', 
  #                                  state:'SP', email: 'sac.facebook@facebook.com')
  #     order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, status: :delivered, estimated_delivery_date: 1.week.from_now)
  #     product_a = ProductModel.create!(name: 'Cadeira Gamer', weight: 5, width: 70, height: 100, depth: 75, supplier: supplier, sku: 'CAD-GAMER-1324')
  #     stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product_a)
  #     stock_product.create_stock_product_destination!(recipient: "Joao", address: "Rua do Joao")

  #     expect(stock_product.available?).to eq false
      
  #   end
    
    
    
  # end
  
  

end
