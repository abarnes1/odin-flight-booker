class BookingsController < ApplicationController
  def index
    return unless search?

    @booking = booking_search(params)
    redirect_to booking_path(@booking) if @booking

    flash.now[:alert] = helpers.booking_not_found_message
  end

  def new
    @flight = Flight.find(params[:flight_id])
    @booking = @flight.bookings.build

    passengers = params[:passenger_count].to_i
    passengers.times { @booking.passengers.build }
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def create
    @booking = Booking.new(booking_params)
    generate_confirmation_code

    if @booking.save
      flash[:notice] = helpers.booking_success_message
      redirect_to booking_path(@booking)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:flight_id, :name, :email, :confirmation_code, passengers_attributes: %i[name email])
  end

  def generate_confirmation_code
    temp_code = String.new
    10.times { temp_code << rand(65..90).chr }

    @booking.confirmation_code = temp_code
  end

  def search?
    return true if params[:commit] == 'Search'
  end

  def booking_search(params)
    booking = Booking.all
    booking.where(confirmation_code: params[:confirmation_code])
    booking.where(email: params[:email])
    booking.first
  end
end
