class OrdersController < ApplicationController
  skip_before_action :authorize, only: [:new, :create]
  before_action :redirect_to_home_if_not_admin, only: [:destroy]
  before_action :redirect_to_home_if_not_manager_or_admin, only: [:show, :edit, :update]
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  after_action :send_invoice_email, only: [:create]
  after_action :create_order_user, only: [:create]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
    @cache_key_orders = cache_key('all', @orders)
    fresh_when @cache_key_orders, public: true
  end

  # GET /orders/1
  # GET /orders/1.json
  # GET /orders/1.pdf
  def show
    #respond_with @order if stale? @order # another method of caching
    fresh_when @order
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to home_path, notice: 'Order was successfully created.' }
        format.json { render action: 'show', status: :created, location: @order }
      else
        format.html { render action: 'new' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to home_path, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:type_of_certificate_id, :type_of_legal_entity_id, :company, :creator_name, :registered_address, :actual_address, :address_on_english, :phone, :fax, :email, :inn, :kpp, :ogrn, :bank, :current_account, :correspondent_account, :bik, :bank_person, :auditors_names, :status_id, :list_of_works_category_ids => [])
    end
    
    def redirect_to_home_if_not_admin
      redirect_to home_url unless current_user.admin?
    end
    
    def redirect_to_home_if_not_manager_or_admin
      redirect_to home_url unless current_user.manager? or current_user.admin?
    end

    def cache_key(filter, orders)
      count          = orders.count
      max_updated_at = orders.maximum(:updated_at).try(:utc).try(:to_s, :number)
      "orders/#{filter}-#{count}-#{max_updated_at}"
    end
    
    def send_invoice_email
      MainMailer.invoice(@order).deliver if @order.save
    end
    
    def create_order_user
      rand_password = ('a'..'z').to_a.shuffle.first(8).join
      user = User.new(
        email: @order.email, 
        password: rand_password, 
        password_confirmation: rand_password, 
        permission: Permission.find_by(title: "client")
        )
      MainMailer.welcome(user).deliver if user.save
    end
end
