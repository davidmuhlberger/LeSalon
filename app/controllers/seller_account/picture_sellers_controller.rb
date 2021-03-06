module SellerAccount
  class PictureSellersController < SellerAccount::BaseController
    before_action :authenticate_seller!

    def index
      @pictures = policy_scope(PictureSeller)
    end


    def new
      @picture = PictureSeller.new
      authorize @picture
    end

    def create
      @picture = current_seller.picture_sellers.build(picture_params)
      @picture.seller = current_seller
      authorize @picture
      if @picture.save
        redirect_to seller_account_sellers_profile_path
      else
        render :new
      end
    end

    def destroy
      find_picture
      authorize @picture
      @picture.destroy
      redirect_to seller_account_sellers_profile_path
    end

    private

    def picture_params
      params.require(:picture_seller).permit(:picture)
    end

    def find_picture
      @picture = current_seller.picture_sellers.find(params[:id])
    end

  end
end
