class ProductsNotifierMailer < ApplicationMailer
  default from: 'warsztaty@infakt.pl'
  layout 'mailer'

  def borrow_book(book, user)
    @book = book
    @user = user

    mail(to: user.email, subject: "Wypożyczyłeś książkę #{book.title}")
  end
end
