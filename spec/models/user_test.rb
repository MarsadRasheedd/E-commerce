# frozen_string_literal: true

require 'test_helper'

RSpec.describe User, type: :model do
  subject do
    described_class.new(
      id: 1,
      first_name: 'rana',
      last_name: 'marsad',
      email: 'ranamarsad@gmail.com',
      address: 'gujranwala',
      phone: 123_456_789,
      encrypted_password: '$2a$10$8uCZ9wCTsFoqa0aIfpssne4qtchcpqhepdU5WylZwh4GBAkgFWEYe',
      cartt_id: 1
    )
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end
end
