class OffersController < ApplicationController
  def for_listing
    @listing = Listing.find(params[:id])
    @offers = @listing.offers
  end

  def index
    @listing = Listing.find(params["id"])
    @offers = @listing.offers
  end

  def create
    @listing = Listing.find(params[:listing_id])
    @offer = @listing.offers.new(offer_params)
    @offer.user = current_user
    @offer.price = @offer.listing.price
    @offer.period = @offer.listing.max
    if @offer.save
      redirect_to listing_path(@listing), notice: "Thank you for making an offer for this Listing! You can check the status on the Dashboard."
    else
      puts @offer.errors.full_messages
    end
  end

  def destroy
    @offer = Offer.find(params[:id])
    if @offer.destroy
      # hide the default tab value inside the params

      redirect_to dashboard_path(tab: "Offers"), notice: 'Offer deleted.'
      # flash.now[:notice] = 'Offer deleted.'
    else
      puts @offer.errors.full_messages
    end
  end

  def update
    @offer = Offer.find(params[:id])
    if @offer.update(offer_params)
      redirect_to offers_path(@offer.listing)
    else
      render :for_listing
    end
  end

  private

  def offer_params
    params.require(:offer).permit(:comments, :start_date, :status)
  end
end
