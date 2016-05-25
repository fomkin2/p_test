require 'rails_helper'

RSpec.describe Page, type: :model do
  it "uid should uniquid" do
    expect(Page.create!(uid: 'uid').uid).to eq 'uid'
    expect {Page.create!(uid: 'uid')}.to raise_error(ActiveRecord::RecordInvalid)
  end
end
