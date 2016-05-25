require 'rails_helper'

RSpec.describe "Carts", type: :request do
  before(:example) do
    sign_in_as_a_valid_user
  end
end
