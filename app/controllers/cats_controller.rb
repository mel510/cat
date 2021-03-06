class CatsController < ApplicationController
  before_action :current_cat, only: [:edit, :show, :update, :destroy]

  def index
    @cats = current_user.cats
    render json: @cats
  end

  def new
    @cat = Cat.new
  end

  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id if current_user
    if @cat.save
      redirect_to cat_path(@cat)
    else
      flash[:notice] = "Please name your cat"
      render :new
    end
  end

  def update
    if @cat.update (cat_params)
      redirect_to cat_path(@cat)
    else
      render :edit
    end
  end

  def show
    @cat = Cat.find(params[:id])
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @cat }
    end
  end

  def edit
  end

  def destroy
    @cat.delete
    redirect_to root_path, notice: "#{@cat.name} was deleted"
  end

  def most_talented
    @cats = Cat.most_talented
  end

  private
    def cat_params
      params.require(:cat).permit(:name, :color, trick_ids:[], tricks_attributes: [:name, :description])
    end

    def current_cat
      @cat = Cat.find_by_id(params[:id])
    end

end
