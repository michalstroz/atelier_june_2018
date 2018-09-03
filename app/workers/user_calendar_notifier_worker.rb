class UserCalendarNotifierWorker
  include Sidekiq::Worker

  def perform(user_id, book_id)
    user = User.find(user_id)
    book = Book.find(book_id)
    reservation = book.reservations.where(user: user).last
    UserCalendarNotifier.new(user).perform(reservation)
  end
end
