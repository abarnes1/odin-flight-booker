class BookingsController < ApplicationController
  def new
    @flight = Flight.find(booking_params[:flight_id])
    @booking = @flight.bookings.build(booking_params)

    passengers = params[:booking][:passenger_count].to_i
    passengers.times { @booking.passengers.build }
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def create
    @booking = Booking.new(booking_params)
    generate_confirmation_code

    if @booking.save
      redirect_to booking_path(@booking)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:flight_id, :name, :email, passengers_attributes: [:name, :email])
  end

  def generate_confirmation_code
    temp_code = String.new
    10.times { temp_code << rand(65..90).chr }

    @booking.confirmation_code = temp_code
  end
end
