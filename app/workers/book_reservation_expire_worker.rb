class BookReservationExpireWorker
  include Sidekiq::Worker

  def perform(book_id)
    book = Book.find(book_id)
    BooksNotifierMailer.book_return_reminder(book).deliver
    BooksNotifierMailer.book_reserved_return(book).deliver
  end
end
