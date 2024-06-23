class ItemsController < ApplicationController
  
	def show
    @item = Item.find(params[:id])
    @place = Place.find(params[:place_id])
	end
  
  def update
    @item = Item.find(params[:id])
    place = Place.find(params[:place_id])

    item_params[:place_id] = nil if item_params[:place_id].blank?
    
    @item.update(item_params)
    if @item.save
      notice = @item.user == nil ? "You dropped #{@item.name}" : "You picked up #{@item.name}"
      redirect_to place_path(place), notice: notice
    else
      render :show, status: :unprocessable_entity
    end
  end
  
  private
  
  def item_params
    params.require(:item).permit(:name, :description, :user_id, :place_id)
  end
end
