class CatTricksController < ApplicationController
  before_action :current_cat_trick, only: [:edit, :update]
    before_action :current_cat, only: [:edit, :update]

  def edit
    @cat = Cat.find_by_id(@cat_trick.cat_id)
    @trick = Trick.find_by_id(@cat_trick.trick_id)
  end

  def update
    @cat = Cat.find_by_id(@cat_trick.cat_id)
    @cat_trick.update (cat_trick_params)
    redirect_to cat_path(@cat)
  end

  private
    def cat_trick_params
      params.require(:cat_trick).permit(:rating)
    end

    def current_cat_trick
      @cat_trick = CatTrick.find_by_id(params[:id])
    end

    def current_cat
      @cat = Cat.find_by_id(params[:id])
    end

end
