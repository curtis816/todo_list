class ItemsController < ApplicationController
  before_action :set_list

  def create
    @item = @list.items.create(item_params)

    redirect_to @list
  end

  def destroy
    @item = @list.items.find(params[:id])
    if @item.destroy
      redirect_to @list, alert: "Item was deleted!"
    else
      redirect_to @list, alert: "Item can't be deleted"
    end
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def item_params
    params[:item].permit(:content)
  end
end
