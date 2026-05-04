class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :destroy]

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
    # 削除ボタンを押されて削除されるデータがあった場合に走るメソッド
    remove_images

    # 画像の追加などがあった時にupdateだと一枚になってしまうので保存を別で走らせるメソッド
    if params[:item][:images]
      params[:item][:images].each do |image|
        @item.images.attach(image)
      end
    end

    if @item.update(item_params.except(:images))
      redirect_to @item
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
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
                                   {images:[]}
                                   ).merge(user_id: current_user.id)
    end

    def set_item
      @item = Item.find(params[:id])
    end

    def move_to_index
      if (@item.user_id != current_user.id) || @item.purchase.present?
        redirect_to root_path
      end
    end

    # 編集で画像を消したい場合に走るメソッド
    def remove_images
      return unless params.dig(:item, :remove_image_ids)

      params[:item][:remove_image_ids].each do |id|
        @item.images.find(id).purge
      end
    end

end