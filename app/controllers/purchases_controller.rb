class PurchasesController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @purchase_shipping_address = PurchaseShippingAddress.new
  end

  def create
    @purchase_shipping_address = PurchaseShippingAddress.new(p_s_a_params)
    if @purchase_shipping_address.valid?
      @purchase_shipping_address.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render :index, status: :unprocessable_entity
    end
  end


  private
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
