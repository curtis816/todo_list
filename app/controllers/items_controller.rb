class ItemsController < ApplicationController
  before_action :set_list
  before_action :set_item, except: [:create]
  before_action :authenticate_user!, only: [:create,:destroy,:complete,:not_complete]

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
    if @list.editable_by?(current_user)
      @item.update_attribute(:completed_at, Time.now)
      redirect_to @list, notice: "Item completed"
    else
      redirect_to @list, alert: "You can't update status"
    end
  end

  def not_complete
    if @list.editable_by?(current_user)
      @item.update_attribute(:completed_at, nil)
      redirect_to @list, notice: "Item not complete yet."
    else
      redirect_to @list, alert: "You can't update status"
    end
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
