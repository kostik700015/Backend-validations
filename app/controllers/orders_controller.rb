class OrdersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found
    before_action :set_order, except: [:index, :new, :create]
    


    def index
        @orders = Order.all
    end

    def new
        @order = Order.new
        # if @order.save
        #     flash.notice = "The order record was created successfully."
        #     redirect_to @order
        #   else
        #     flash.now.alert = @order.errors.full_messages.to_sentence
        #     render :new  
        #   end
    end

    def create 
        # byebug
        @customer = Customer.find(params[:order][:customer_id])
        @order = @customer.orders.create(order_params)
        if @order.save
            flash.notice = "The order record was created successfully."
            redirect_to @order
        else
            flash.now.alert = @order.errors.full_messages.to_sentence
            render :new  
        end
    end

    def show
        customerId = @order.customer_id
        @customer = Customer.find(customerId)
    end

    def edit
    end

    def update
        @order = Order.find(params[:id])
        #@order.update(order_params)
       
        if @order.update(order_params)
            flash.notice = "The order record was updated successfully."
            redirect_to @order
          else
            flash.now.alert = @order.errors.full_messages.to_sentence
            render :edit
          end
        
    end

    def destroy 
        @order.destroy
        respond_to do |format|
          format.html { redirect_to orders_url, notice: "order was successfully destroyed." }
          format.json { head :no_content }
        end
    end

    private
    def order_params
        params.require(:order).permit(:product_name, :product_count, :customer_id)
    end

    def set_order
        @order = Order.find(params[:id])
    end
    def catch_not_found(e)
        Rails.logger.debug("We had a not found exception.")
        flash.alert = e.to_s
        redirect_to orders_path
      end
  



end

