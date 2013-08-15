class OrdersController < ApplicationController
  include ApplicationHelper
    
  skip_before_action :authorize, only: [:new, :create]
  before_action :check_pemissions, only: [:show, :edit, :update, :destroy]
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  # GET /orders/1.pdf
  def show
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
    @order.status_id = Status.find_by_title("Новый").id

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
      format.html { redirect_to  :back }
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
    
    def check_pemissions
      redirect_to home_path if not (permission == 'admin' or permission == 'manager')
    end 
end
