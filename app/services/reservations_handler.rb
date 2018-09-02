class ReservationsHandler
  def initialize(user, book)
    @user = user
    @book = book
  end

  def reserve
    return "Book is not available for reservation" unless book.can_reserve?(user)
    book.reservations.create(user: user, status: 'RESERVED')
  end

  def cancel_reservation
    book.reservations.where(user: user, status: 'RESERVED').order(created_at: :asc).first.update_attributes(status: 'CANCELED')
  end

  def take
    return "Book can not be taken at the moment" unless book.can_take?(user)
    if book.available_reservation.present?
      # perform_expiration_worker(book.available_reservation)
      book.available_reservation.update_attributes(status: 'TAKEN')
    else
      book.reservations.create(user: user, status: 'TAKEN')
      # perform_expiration_worker(book.reservations.create(user: user, status: 'TAKEN'))
    end
    # notify_user_calendar
    # BooksNotifierMailer.borrow_a_book(book, user).deliver_now
  end

  def give_back
     ActiveRecord::Base.transaction do
       book.reservations.find_by(status: 'TAKEN').update_attributes(status: 'RETURNED')
       notify_user_calendar
       book.next_in_queue.update_attributes(status: 'AVAILABLE') if book.next_in_queue.present?
       book_is_available_mailer
     end
  end

  def notify_user_calendar
    UserCalendarNotifier.new(user).perform(provide_reservation)
  end

  def borrow_a_book
    # BooksNotifierMailer.borrow_a_book(book, user).deliver_now
    BorrowBookMailerJob.perform_later(book, user)
  end

  def book_is_available_mailer
    SendAvailableBookMailerJob.perform_later(book)
  end

  private

  attr_reader :user, :book

  # def perform_expiration_worker(res)
  #  # ::BookReservationExpireWorker.perform_at(res.expires_at-1.day, res.book_id)
  #   BookReservationExpireJobJob.set(wait_until: res.expires_at-1.day).perform_later(res.book)
  # end



  def provide_reservation
    book.reservations.where(user: user).last
  end
end
