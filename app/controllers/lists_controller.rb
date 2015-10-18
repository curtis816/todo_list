class ListsController < ApplicationController

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
    @list = List.find(params[:id])
  end

  def create
    @list = List.create(list_params)

    if @list.save
      redirect_to lists_path
    else
      render :new
    end
  end

  def update
    @list = List.find(params[:id])

    if @list.update(list_params)
      redirect_to list_path, notice: "修改Todo list成功"
    else
      render :edit
    end
  end

  def destroy
    @list = List.find(params[:id])

    @list.destroy
    redirect_to lists_path, alert: "List was deleted"
  end

  private

  def list_params
    params.require(:list).permit(:title, :description)
  end
end