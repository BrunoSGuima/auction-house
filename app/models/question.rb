class Question < ApplicationRecord
  belongs_to :user
  belongs_to :auction_lot
  belongs_to :admin, class_name: 'User', optional: true
end
