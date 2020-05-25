require 'rails_helper'

describe SomethingsController, type: :controller do
  let!(:somethings) { create_list(:something, 100) }

  describe 'GET #index' do
    def request
      get :index, params: { }
    end

    def request_with_cursor(cursor)
      get :index, params: { cursor: cursor }
    end

    it_behaves_like 'success response'

    it 'renders current jbuilder template' do
      request
      expect(response).to render_template :index
    end

    it 'return first 10 (default) records' do
      request
      data = JSON.parse(response.body)['data']
      expect(data.length).to eq 10
    end

    it 'return last records' do
      request_with_cursor(somethings.last(3).first.created_at)
      data = JSON.parse(response.body)['data']
      expect(data.length).to eq 2
    end

    it 'return no records' do
      request_with_cursor(somethings.last.created_at)
      data = JSON.parse(response.body)['data']
      expect(data.length).to eq 0
    end
  end
end
