class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_index

  def index
    item_set
    @purchase_shipping_address = PurchaseShippingAddress.new
  end

  def create
    @purchase_shipping_address = PurchaseShippingAddress.new(p_s_a_params)
    if @purchase_shipping_address.valid?
      @purchase_shipping_address.save
      redirect_to root_path
    else
      item_set
      render :index, status: :unprocessable_entity
    end
  end


  private
    def move_to_index
      item_set
      if @item.user_id == current_user.id || @item.purchase.present?
        redirect_to root_path
      end
    end

    def item_set
      @item = Item.find(params[:item_id])
    end

    def p_s_a_params
      params.require(:purchase_shipping_address).permit(:post_code,
                                                        :prefecture_id,
                                                        :address,
                                                        :house_number,
                                                        :building,
                                                        :tel).merge(user_id: current_user.id,
                                                                    item_id: params[:item_id])
  end

end
