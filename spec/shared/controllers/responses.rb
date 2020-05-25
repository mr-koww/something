shared_examples_for 'success response' do
  it 'has status success (200)' do
    request
    expect(response.status).to eq 200
  end
end
