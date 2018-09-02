class BookReservationExpireJobJob < ApplicationJob
  queue_as :default

  def perform(book)
    ::BooksNotifierMailer.book_return_reminder(book).deliver_later
    ::BooksNotifierMailer.book_reserved_return(book).deliver_later
  end
end
