class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :cpf, presence: true
  validates :cpf, uniqueness: true
  validate :cpf_validation

  enum role: [:user, :admin]
  after_initialize :set_default_role, :if => :new_record?
  before_save :set_admin_role

  def set_default_role
    self.role ||= :user
  end

  def description
    "#{name} - #{email} - #{role}" 
  end

  private
  
  def set_admin_role
    if self.email.present? && self.email.match(/@leilaodogalpao\.com\.br\z/)
      self.role = :admin
    end
  end

  def cpf_validation
    errors.add(:cpf, 'INVÁLIDO!') unless cpf_valido(cpf)
  end

  def cpf_valido(cpf)
    return false if cpf.length != 11
  
    sum1 = 0
    9.times do |i|
      sum1 += cpf[i].to_i * (10 - i)
    end
  
    remainder1 = sum1 % 11
    first_digit = remainder1 < 2 ? 0 : 11 - remainder1
    return false if first_digit != cpf[9].to_i
  
    sum2 = 0
    10.times do |i|
      sum2 += cpf[i].to_i * (11 - i)
    end
  
    remainder2 = sum2 % 11
    second_digit = remainder2 < 2 ? 0 : 11 - remainder2
    return false if second_digit != cpf[10].to_i
  
    true
  end
  
end
