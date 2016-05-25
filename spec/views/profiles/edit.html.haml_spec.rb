require 'rails_helper'

RSpec.describe "profiles/edit", type: :view do
  before(:each) do
    @profile = assign(:profile, create(:profile))
  end

  it "renders the edit profile form" do
    render

    assert_select "form[action=?][method=?]", '/profile', "post" do
    end
  end
end
