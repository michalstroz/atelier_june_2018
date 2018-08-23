class BookReservationExpireJobJob < ApplicationJob
  queue_as :default

  def perform(book)
    ::BooksNotifierMailer.book_return_reminder(book).deliver
    ::BooksNotifierMailer.book_reserved_return(book).deliver
  end
end
