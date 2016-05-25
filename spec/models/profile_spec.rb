require 'rails_helper'

RSpec.describe Profile, type: :model do
  it 'name can not be nil' do
    profile = build :profile, name: nil
    expect(profile.save).to eq(false)
  end

  it 'phone can not be nil' do
    profile = build :profile, phone: nil
    expect(profile.save).to eq(false)
  end
end
