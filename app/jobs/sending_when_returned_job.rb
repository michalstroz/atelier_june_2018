class SendingWhenReturnedJob < ApplicationJob
  queue_as :default

  def perform(book_id)
    # Do something later
    book = Book.find(book_id)
    BooksNotifierMailer.book_available_earlier(book).deliver
  end
end
