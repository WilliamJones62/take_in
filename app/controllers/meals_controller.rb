class MealsController < ApplicationController
  before_action :build_lists, only: [:new, :create, :edit, :update]
  before_action :set_meal, only: [:show, :edit, :update, :destroy]
  before_action :build_totals, only: [:index]
  before_action :build_meals, only: [:list, :selected]
  before_action :set_image, only: [:showimage]

  def collected
    meal = Meal.find(params[:id])
    if meal.collected_flag == true
      meal.collected_flag = false
    else
      meal.collected_flag = true
    end
    meal.save
    redirect_to meals_path, notice: 'Order updated.'
  end

  def delivered
    meal = Meal.find(params[:id])
    if meal.delivered_flag == true
      meal.delivered_flag = false
    else
      meal.delivered_flag = true
    end
    meal.save
    redirect_to meals_path, notice: 'Order updated.'
  end

  def list
    @windows = ['12:00pm-1:00pm (Hot)', '2:00pm-2:30pm (Hot)', 'Warehouse refrigerator', 'Office refrigerator']
    if @menu_date
      if Date.today == @menu_date.to_date
        if Time.now > Time.now.beginning_of_day + 11.hours
          @windows = ['2:00pm-2:30pm (Hot)', 'Warehouse refrigerator', 'Office refrigerator']
        elsif Time.now > Time.now.beginning_of_day + 13.hours
          @windows = ['Warehouse refrigerator', 'Office refrigerator']
        elsif Time.now > Time.now.beginning_of_day + 14.hours
          @windows = []
        end
      end
    end
  end

  def showimage
  end

  def selected
    employee = Employee.find_by Badge_: current_user.email
    order_requested = false
    order_successful = true
    i = 0
    loop do
      i += 1
      idi = 'id'+i.to_s
      qtyi = 'qty'+i.to_s
      collect_windowi = 'collect_window'+i.to_s
      if params[idi].blank?
        break
      end
      if !params[qtyi].blank?
        # the user wants something, is there enough?
        order_requested = true
        menu = Menu.find(params[idi])
        if menu.blank?
          order_successful = false
          redirect_to meals_list_path, notice: 'Dish not available.'
          break
        else
          meals = Meal.where(title: menu.title).where(menu_date: menu.menu_date)
          total = 0
          meals.each do |m|
            total += m.qty
          end
          remaining = menu.qty - total
          if remaining - params[qtyi].to_i < 0
            order_successful = false
            redirect_to meals_list_path, notice: 'Insufficient dishes remaining for order.'
            break
          end
          if !employee.image.blank?
            meal = Meal.new(title: menu.title, collect_window: params[collect_windowi], qty: params[qtyi], employee: employee.name, menu_date: menu.menu_date, image: employee.id.to_s+"/thumb_"+employee.image, normal_image: employee.id.to_s+"/normal_"+employee.image)
          else
            meal = Meal.new(title: menu.title, collect_window: params[collect_windowi], qty: params[qtyi], employee: employee.name, menu_date: menu.menu_date)
          end
          meal.save
        end
      end
    end
    if order_successful
      if order_requested
        redirect_to meals_display_path, notice: 'Order was successfully created.'
      else
        redirect_to meals_list_path, notice: 'No order entered.'
      end
    end
  end

# GET /meals
  def index
    @meals = []
    if Time.now > Time.now.beginning_of_day + 15.hours
      first_menu = Menu.where('menu_date > ?', Date.today).take(1)
    else
      first_menu = Menu.where('menu_date > ?', Date.yesterday).take(1)
    end

    if first_menu.length > 0
      first_menu.each do |f|
        @menu_date = f.menu_date
      end
      @meals = Meal.where(menu_date: @menu_date)
    end
  end

  def display
    employee = Employee.find_by Badge_: current_user.email
    if Time.now > Time.now.beginning_of_day + 13.hours
      first_menu = Menu.where('menu_date > ?', Date.today).take(1)
    else
      first_menu = Menu.where('menu_date > ?', Date.yesterday).take(1)
    end

    @meals = []
    if first_menu.length > 0
      first_menu.each do |f|
        @menu_date = f.menu_date
      end
      @meals = Meal.where(menu_date: @menu_date).where(employee: employee.name)
    end
  end

  # GET /meals/1
  def show
  end

  # GET /meals/new
  def new
    @meal = Meal.new
    @new = true
  end

  # GET /meals/1/edit
  def edit
    @new = false
  end

  # POST /meals
  def create
    @meal = Meal.new(meal_params)
    @meal.menu_date = Date.today
    @new = true
    employees = Employee.where(Employee_Status: "ACTIVE")
    employees.each do |e|
      if e.Firstname+' '+e.Lastname == @meal.employee
        if e.image.blank?
          @meal.image = 'DArtagnan_Logo_2015_CMYK_tiny.jpg'
          @meal.normal_image = 'DArtagnan_Logo_2015_CMYK_mini.jpg'
        else
          @meal.image = "http://employees.dartagnan.com/uploads/employee/image/"+e.id.to_s+"/thumb_"+e.image
          @meal.normal_image = "http://employees.dartagnan.com/uploads/employee/image/"+e.id.to_s+"/normal_"+e.image
        end
        break
      end
    end

    respond_to do |format|
      if @meal.save
        format.html { redirect_to destroy_user_session_path, notice: 'Order was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /meals/1
  def update
    @new = false
    respond_to do |format|
      if @meal.update(meal_params)
        format.html { redirect_to @meal, notice: 'Order was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /meals/1
  def destroy
    @meal.destroy
    respond_to do |format|
      format.html { redirect_to meals_url, notice: 'Order was successfully deleted.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meal
      @meal = Meal.find(params[:id])
    end

    def build_meals
      @meals = []
      if Time.now > Time.now.beginning_of_day + 13.hours
        first_menu = Menu.where('menu_date > ?', Date.today).take(1)
      else
        first_menu = Menu.where('menu_date > ?', Date.yesterday).take(1)
      end

      menus = []
      if first_menu.length > 0
        first_menu.each do |f|
          @menu_date = f.menu_date
        end
        menus = Menu.where(menu_date: @menu_date)
      end
      menus.each do |m|
        meals = Meal.where(title: m.title).where(menu_date: m.menu_date)
        total = 0
        meals.each do |meal|
          total += meal.qty
        end
        remaining = m.qty - total
        hash = {title: m.title, description: m.description, qty_left: remaining, image: m.image, id: m.id}
        @meals.push(hash)
      end
    end

    def build_lists
      @titles = []
      if Time.now > Time.now.beginning_of_day + 13.hours
        first_menu = Menu.where('menu_date > ?', Date.today).take(1)
      else
        first_menu = Menu.where('menu_date > ?', Date.yesterday).take(1)
      end

      titles = []
      if first_menu.length > 0
        first_menu.each do |f|
          @menu_date = f.menu_date
        end
        titles = Menu.where(menu_date: @menu_date)
      end
      titles.each do |t|
        meals = Meal.where(title: t.title).where(menu_date: t.menu_date)
        total = 0
        meals.each do |m|
          total += m.qty
        end
        remaining = t.qty - total
        if !@titles.include?(t.title)
          @titles.push(t.title)
        end
      end

      @windows = ['12:00pm-1:00pm (Hot)', '2:00pm-2:30pm (Hot)', 'Warehouse refrigerator', 'Office refrigerator']
    end

    def build_totals
      windows = ['12:00pm-1:00pm (Hot)', '2:00pm-2:30pm (Hot)', 'Warehouse refrigerator', 'Office refrigerator']
      @totals = []
      titles = []
      if Time.now > Time.now.beginning_of_day + 15.hours
        first_menu = Menu.where('menu_date > ?', Date.today).take(1)
      else
        first_menu = Menu.where('menu_date > ?', Date.yesterday).take(1)
      end

      if first_menu.length > 0
        first_menu.each do |f|
          @menu_date = f.menu_date
        end
        titles = Menu.where(menu_date: @menu_date)
      end
      titles.each do |t|
        total_qty = 0
        title = t.title
        windows.each do |w|
          meals = Meal.where(title: t.title).where(menu_date: t.menu_date).where(collect_window: w)
          if meals.length > 0
            qty = 0
            meals.each do |m|
              qty += m.qty
              total_qty += m.qty
            end
            total_hash = {title: title, window: w, qty: t.qty, ordered: qty, remaining: (t.qty - qty)}
            @totals.push(total_hash)
            title = ' '
          end
        end
        total_hash = {title: "Totals", window: ' ', qty: t.qty, ordered: total_qty, remaining: (t.qty - total_qty)}
        @totals.push(total_hash)
      end
    end

    def set_image
      # find the menu item and pass the normal_image
      menu = Menu.find_by title: params[:title]
      if !menu.blank? && !menu.normal_image.blank?
        @menu_image = "http://cookbook.dartagnan.com/uploads/recipe_image/image/"+menu.normal_image
      else
        @menu_image = 'DArtagnan_Logo_2015_CMYK_mini.jpg'

      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meal_params
      params.require(:meal).permit(:title, :collect_window, :qty, :employee, :collected, :menu_date, :image, :collected_flag)
    end
end
