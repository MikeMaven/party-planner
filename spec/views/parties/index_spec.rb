require 'spec_helper'

describe "index" do
  party = FactoryBot.create(:party)
  
  it "shows me a list of parties" do
    visit '/'

    save_and_open_page

    expect(page).to have_content 'Parties'
    expect(page).to have_content 'Parties'
  end
end
