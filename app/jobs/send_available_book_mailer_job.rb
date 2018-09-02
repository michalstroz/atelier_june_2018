class SendAvailableBookMailerJob < ApplicationJob
  queue_as :default

  def perform(book)
     ::BooksNotifierMailer.book_is_available(book).deliver_later
  end
end
