class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update]

  def index
    @items = Item.order("created_at desc")
  end

  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    
  end

  def edit
    
  end

  def update
    if @item.update(item_params)
      redirect_to @item
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
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

    def set_item
      @item = Item.find(params[:id])
    end
end
