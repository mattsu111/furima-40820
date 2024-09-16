class PurchaseRecordsSending
  include ActiveModel::Model
  attr_accessor :token, :postal_code, :prefecture_id, :city, :address, :building, :telephone_number, :user_id, :item_id

  with_options presence: true do
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :telephone_number, format: { with: /\A\d{10,11}\z/, message: "is invalid." }
    validates :user_id
    validates :item_id
    validates :city
    validates :address
    validates :token
  end  
  validates :prefecture_id, numericality: {other_than: 1, message: "can't be blank"}

  def save
    
    purchase_record = PurchaseRecord.create(item_id: item_id, user_id: user_id)

    Sending.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address, building: building, telephone_number: telephone_number, purchase_record_id: purchase_record.id)


  end

end  