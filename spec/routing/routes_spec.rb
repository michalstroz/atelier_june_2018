require 'rails_helper'

describe 'AppRouting' do
  it {
    expect(root: 'books', action: 'index')
  }

  it {
    expect(get: reserve_book_path(book_id: 12)).to route_to(
      controller: 'reservations',
      action: 'reserve',
      book_id: '12'
    )
  }

  it {
    expect(get: take_book_path(book_id: 12)).to route_to(
      controller: 'reservations',
      action: 'take',
      book_id: '12'
    )
  }

  it {
    expect(get: give_back_book_path(book_id: 12)).to route_to(
      controller: 'reservations',
      action: 'give_back',
      book_id: '12'
    )
  }

  it {
    expect(get: cancel_book_reservation_path(book_id: 2)).to route_to(
      controller: 'reservations',
      action: 'cancel',
      book_id: '2'
    )
  }

  it {
    expect(get: google_isbn_path(isbn: '123')).to route_to(
      controller: 'google_books',
      action: 'show',
      isbn: '123'
    )
  }

  it {
    expect(get: users_reservations_path(user_id: 3)).to route_to(
      controller: 'reservations',
      action: 'users_reservations',
      user_id: '3'
    )
  }

  it {
    expect(get: books_path).to route_to(
      controller: 'books',
      action: 'index'
    )
  }

  it {
    expect(get: new_book_path(id: 14)).to route_to(
      controller: 'books',
      action: 'new',
      id: '14'
    )
  }

  it {
    expect(post: books_path(id: 14)).to route_to(
      controller: 'books',
      action: 'create',
      id: '14'
    )
  }

  it {
    expect(get: book_path(id: 12)).to route_to(
      controller: 'books',
      action: 'show',
      id: '12'
    )
  }

  it {
    expect(get: edit_book_path(id: 12)).to route_to(
      controller: 'books',
      action: 'edit',
      id: '12'
    )
  }

  it {
    expect(patch: book_path(id: 12)).to route_to(
      controller: 'books',
      action: 'update',
      id: '12'
    )
  }

  it {
    expect(put: book_path(id: 12)).to route_to(
      controller: 'books',
      action: 'update',
      id: '12'
    )
  }

  it {
    expect(delete: book_path(id: 12)).to route_to(
      controller: 'books',
      action: 'destroy',
      id: '12'
    )
  }


end
