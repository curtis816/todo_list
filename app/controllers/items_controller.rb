class ItemsController < ApplicationController
  before_action :set_list
  before_action :set_item, except: [:create]

  def create
    @item = @list.items.create(item_params)

    redirect_to @list
  end

  def destroy
    if @item.destroy
      redirect_to @list, alert: "Item was deleted!"
    else
      redirect_to @list, alert: "Item can't be deleted"
    end
  end

  def complete
    @item.update_attribute(:completed_at, Time.now)
    redirect_to @list, notice: "Item completed"
  end

  def not_complete
    @item.update_attribute(:completed_at, nil)
    redirect_to @list, notice: "Item not complete"
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def set_item
    @item = @list.items.find(params[:id])
  end

  def item_params
    params[:item].permit(:content)
  end
end
