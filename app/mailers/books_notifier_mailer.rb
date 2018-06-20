class BooksNotifierMailer < ApplicationMailer
  default from: 'warsztaty@infakt.pl'
  layout 'mailer'

  def borrow_a_book(book, user)
    @book = book
    @user = user
    @deadline = user.reservations.where(book_id: @book.id, status: 'TAKEN').last.expires_at

    mail(to: user.email, subject: "Wypożyczyłeś książkę #{book.title}!")
  end
end
