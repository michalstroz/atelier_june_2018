namespace :mail_sending do

  desc 'Sending sailings to group of users day beforeto expires_at'
  task sending_mails_before: :environment do

    expires_reservations = Reservation.where(status: 'TAKEN').where('Date(expires_at) = ?', '2018-06-27')

    if expires_reservations.blank?
      'Tomorrow none of any reservations will end.'
    else
      expires_reservations.each do |res|
        book = Book.find_by(id: res.book_id)
        BooksNotifierMailer.book_return_reminder(book).deliver
        BooksNotifierMailer.book_reserved_return(book).deliver
      end
    end
  end
end
