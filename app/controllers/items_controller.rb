class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render action: :new
    end
  end





  private
    def item_params
      params.require(:item).permit(:name,
                                   :price, 
                                   :description, 
                                   :category_id,
                                   :condition_id, 
                                   :shipping_fee_id, 
                                   :prefecture_id,
                                   :shipping_time_id,
                                   :birthday_on,
                                   :image).merge(user_id: current_user.id)
    end

end
