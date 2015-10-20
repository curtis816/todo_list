class ListsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
    @items = @list.items
  end

  def new
    @list = List.new
  end

  def edit
    @list = current_user.lists.find(params[:id])
  end

  def create
    @list = current_user.lists.create(list_params)

    if @list.save
      redirect_to lists_path
    else
      flash.now[:alert] = '失敗囉'
      render :new
    end
  end

  def update

    @list = current_user.lists.find(params[:id])

    if @list.update(list_params)
      redirect_to list_path, notice: "修改Todo list成功"
    else
      flash.now[:alert] = '尚未完成'
      render :edit
    end
  end

  def destroy

    @list = current_user.lists.find(params[:id])

    @list.destroy
    redirect_to lists_path, alert: "List was deleted"
  end

  private

  def list_params
    params.require(:list).permit(:title, :description)
  end
end
