module SellerAccount
  class ProductRefsController < SellerAccount::BaseController
    before_action :find_product_group

    def index
      @product_refs = []
      @product_group.product_refs.each do |product_ref|
          @product_refs << product_ref
      end
    end

    def new
      @product_ref = ProductRef.new
      authorize @product_ref
    end

    def create
      @product_ref = @product_group.product_refs.build(product_ref_params)
      @product_ref.product_group = @product_group
      authorize @product_ref
      @product_ref.save
      if @product_ref.save
        redirect_to seller_account_product_group_path(@product_group)
      else
        render :new
      end
    end

    def show

    end

    def edit

    end

    def update
      @product_ref.update(product_ref_params)
      # redirect_to
    end

    private

    def product_ref_params
      params.require(:product_ref).permit(:color_name, :price, :promotion_percentage,
        :availability, :delivery_time, :reference)
    end

    def find_product_group
      @product_group = current_seller.product_groups.find(params[:product_group_id])
    end

  end
end
