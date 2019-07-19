feature 'homepage welcome' do
  it 'welcomes user' do
    visit '/'
    expect(page).to have_content "Welcome!"
  end
end
