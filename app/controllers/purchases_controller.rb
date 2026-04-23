class PurchasesController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
  end

  def create
    @purchase_shipping_address = PurchaseShippingAddress.new(p_s_a_params)
    @purchase_shipping_address.save
  end


  private
    def p_s_a_params
      params.require(:purchase_shipping_address).permit(:post_code,
                                                        :prefecture_id,
                                                        :address,
                                                        :house_number,
                                                        :building,
                                                        :tel).merge(uer_id: current_user.id,
                                                                    item_id: @item.id)
  end

end
