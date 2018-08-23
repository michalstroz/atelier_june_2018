class BooksNotifierMailer < ApplicationMailer
  default from: 'warsztaty@infakt.pl'
  layout 'mailer'

  def borrow_a_book(book, user)
    @book = book
    @user = user
    @deadline = user.reservations.where(book_id: @book.id, status: 'TAKEN').last.expires_at

    mail(to: user.email, subject: "Wypożyczyłeś książkę #{book.title}!")
  end

  def book_return_reminder(book)
    @book = book
    @reservation = provide_reservation("TAKEN")
    @borrower = @reservation.try(:user)

    mail(to: @borrower.email, subject: "Upływa termin zwrotu książki #{@book.title}")
  end

  def book_reserved_return(book)
    @book = book
    @reservation = provide_reservation("TAKEN")
    @reserver = provide_reservation("RESERVED").try(:user)

    return if @reservation.blank? || @reserver.blank?

    mail(to: @reserver.email, subject: "Już niedługo będziesz mógł wypożyczyć książkę #{@book.title}")
  end

  def book_is_available(book)
    @book = book
    @reservation = provide_reservation("AVAILABLE")
    @reserver = @reservation.try(:user)

    return if @reservation.blank? || @reserver.blank?

    mail(to: @reserver.email, subject: "Książka którą zarezerwowałeś jest już dostępna")
  end

  private

  def provide_reservation(res_status)
    @book.reservations.find_by(status: res_status)
  end
end
