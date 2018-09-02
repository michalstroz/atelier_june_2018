class BorrowBookMailerJob < ApplicationJob
  queue_as :default

  def perform(book, user)
    ::BooksNotifierMailer.borrow_a_book(book, user).deliver_later
  end
end
