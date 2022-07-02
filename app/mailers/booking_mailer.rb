class BookingMailer < ApplicationMailer
  def booking_email
    @booking = params[:booking]

    mail(to: @booking.email, subject: 'Goose Air - Booking Confirmation')
  end
end
