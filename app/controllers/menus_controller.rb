class MenusController < ApplicationController
  before_action :set_menu, only: [:show, :edit, :update, :destroy]
  before_action :build_lists, only: [:new, :edit, :update, :create]

  # GET /menus
  def index
    @menus = Menu.all
  end

  # GET /menus/1
  def show
  end

  # GET /menus/new
  def new
    @menu = Menu.new
  end

  # GET /menus/1/edit
  def edit
  end

  # POST /menus
  def create
    @menu = Menu.new(menu_params)
    recipe = Recipe.find_by(title: @menu.title)
    if !recipe.blank?
      @menu.description = recipe.description
      photo = RecipeImage.find_by(recipe_id: recipe.id)
      if !photo.blank? && !photo.image.blank?
        @menu.image = photo.id.to_s+"/thumb_"+photo.image
        @menu.normal_image = photo.id.to_s+"/normal_"+photo.image
      end
    end

    respond_to do |format|
      if @menu.save
        format.html { redirect_to @menu, notice: 'Menu was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /menus/1
  def update
    recipe = Recipe.find_by(title: @menu.title)
    if !recipe.blank?
      @menu.description = recipe.description
      photo = RecipeImage.find_by(recipe_id: recipe.id)
      if !photo.blank? && !photo.image.blank?
        @menu.image = "http://cookbook.dartagnan.com/uploads/recipe_image/image/"+photo.id.to_s+"/thumb_"+photo.image
        @menu.normal_image = "http://cookbook.dartagnan.com/uploads/recipe_image/image/"+photo.id.to_s+"/normal_"+photo.image
      end
    end

    respond_to do |format|
      if @menu.update(menu_params)
        format.html { redirect_to @menu, notice: 'Menu was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /menus/1
  def destroy
    @menu.destroy
    respond_to do |format|
      format.html { redirect_to menus_url, notice: 'Menu was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu
      @menu = Menu.find(params[:id])
    end

    def build_lists
      @windows = ["11-11:30", "11-12", "11:30-12", "11:30-12:30", "12-12:30", "12-1", "12:30-1", "12:30-1:30", "1-1:30", "1-2", "1:30-2", "1:30-2:30", "2-2:30", "2-3"]
      @titles = []
      recipes = Recipe.all
      recipes.each do |r|
        @titles.push(r.title)
      end
      @titles.sort!
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def menu_params
      params.require(:menu).permit(:menu_date, :qty, :title, :window)
    end
end
