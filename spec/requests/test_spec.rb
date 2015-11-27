require "rails_helper"

describe "mathmatics" do
  example "1 + 1" do
    get "/api/v1/users/hello"
    expect(1 + 1).to eq 2
  end
end
