require'rails_helper'

describe CountriesController do

  describe 'GET #index' do
    it "populates an array of all countries" do
      france = create(:country, name: "France", population: 60000000)
      germany = create(:country, name: "Germany", population: 80000000)
      get :index
      expect(assigns(:countries)).to match_array([france, germany])
    end

    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    it "assigns the requested country to @country" do
      country = create(:country)
      get :show, id: country
      expect(assigns(:country)).to eq country
    end

    it "renders the :show template" do
      country = create(:country)
      get :show, id: country
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    it "assigns a new country to @country" do
      get :new
      expect(assigns(:country)).to be_a_new(Country)
    end
    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    it "assigns the requested country to @country" do
      country = create(:country)
      get :edit, id: country
      expect(assigns(:country)).to eq country
    end

    it "renders the :edit template" do
      country = create(:country)
      get :edit, id: country
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context "with valid attributes" do
      it "saves the new country in the database" do
        expect{
          post :create, country: attributes_for(:country)
        }.to change(Country, :count).by(1)
      end
      it "redirects to countries#show" do
        post :create, country: attributes_for(:country)
        expect(response).to redirect_to country_path(assigns[:country])
      end
    end

    context "with invalid attributes" do
      it "does not save the new country in the database" do
        post :create, country: attributes_for(:country, name: nil)
        expect(Country.count).to eq(0)
      end
      it "re-renders the :new template" do
        post :create, country: attributes_for(:country, name: nil)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    before :each do
      @country = create(:country, name: 'Germany', population: 80000000)
    end

    context "with valid attributes" do
      it "locates the requested @country" do
        patch :update, id: @country, country: attributes_for(:country)
        expect(assigns(:country)).to eq(@country)
      end
      it "changes @country's attributes" do
        patch :update, id: @country,
          country: attributes_for(:country,
            name: 'Switzerland',
            population: 8000000)
        @country.reload
        expect(@country.name).to eq('Switzerland')
        expect(@country.population).to eq(8000000)
      end
      it "redirects to the updated country" do
        patch :update, id: @country,
          country: attributes_for(:country)
        expect(response).to redirect_to @country
      end
    end

    context "with invalid attributes" do
      it "does not change the country's attributes" do
        patch :update, id: @country,
          country: attributes_for(:country,
            name: 'Swizterland',
            population: nil)
        @country.reload
        expect(@country.name).not_to eq('Swizterland')
        expect(@country.population).to eq(80000000)
      end
      it "re-renders the :edit template" do
        patch :update, id: @country,
          country: attributes_for(:country, name: nil)
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @country = create(:country)
    end

    it "deletes the country from the database" do
      expect{
        delete :destroy, id: @country
      }.to change(Country,:count).by(-1)
    end

    it "redirects to countries#index" do
      delete :destroy, id: @country
      expect(response).to redirect_to countries_path
    end
  end
end
