class PurchaseRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_purchase_record, only: [:index, :create]


  def index
    @purchase_records_sending = PurchaseRecordsSending.new
    if current_user.id == @item.user_id || @item.purchase_record != nil
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    end
  end

  def create
    @purchase_records_sending = PurchaseRecordsSending.new(purchase_record_params)
    if @purchase_records_sending.valid?
      pay_item
      @purchase_records_sending.save
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end

  private

  def purchase_record_params
    params.require(:purchase_records_sending).permit(
      :postal_code, :prefecture_id, :city, :address, 
      :building, :telephone_number
    ).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_record_params[:token],
      currency: 'jpy'
    )
  end



  def set_purchase_record
    @item = Item.find(params[:item_id])
  end
end