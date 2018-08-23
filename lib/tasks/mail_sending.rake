namespace :mail_sending do

  desc 'Sending sailings to group of users day beforeto expires_at'
  task sending_mails_before: :environment do

    expires_reservations = Reservation.where(status: 'TAKEN').where('Date(expires_at) = ?', Date.tomorrow)

    if expires_reservations.blank?
      'Tomorrow none of any reservations will end.'
    else
      expires_reservations.each do |res|
        BookReservationExpireJobJob.set(wait_until: res.expires_at-1.day).perform_later(res.book)
      end
    end
  end
end
