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
    @reservation = book.reservations.find_by(status: "TAKEN")
    @borrower = @reservation.user

    mail(to: @borrower.email, subject: "Upływa termin zwrotu książki #{@book.title}")
  end

  def book_reserved_return(book)
    @book = book
    @reservation = book.reservations.find_by(status: "RESERVED")
    unless @reservation.nil?
      @reserver = @reservation.user

      mail(to: @reserver.email, subject: "Już niedługo będziesz mógł wypożyczyć książkę #{@book.title}")
    end
  end
end
