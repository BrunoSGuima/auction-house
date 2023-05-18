require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#description' do
    it "exibe o nome, email e role" do

      u = User.create!(name: 'Julia Almeida', email: 'julia@yahoo.com', password: '123456', cpf:'48625343171')

      result = u.description()

      expect(result).to  eq('Julia Almeida - julia@yahoo.com')
      expect(result).not_to  eq('Julia Almeida - julia@yahoo.com - ADMIN')
      
    end

    it "exibe o nome, email e role do admin" do

      u = User.create!(name: 'Julia do Pão', email: 'julia@leilaodogalpao.com.br', password: '123456', cpf:'48625343171')

      result = u.admin_desc()

      expect(result).to  eq('Julia do Pão - julia@leilaodogalpao.com.br - ADMIN')
      expect(User.last.role).to eq "admin"
      
    end
    
    
  end

end