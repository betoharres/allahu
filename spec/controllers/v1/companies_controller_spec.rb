require 'rails_helper'
# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe V1::CompaniesController, type: :controller do

  create_user_company
  login_user

  before :all do
    Apartment::Tenant.switch!(@company.subdomain)
    @permission = FactoryGirl.create(:permission, role: @user.role)
  end
  # This should return the minimal set of attributes required to create a valid
  # Company. As you add validations to Company, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {name: 'TestName', subdomain: 'testname'}
  }

  let(:invalid_attributes) {
    {name: nil, subdomain: nil}
  }

  describe "GET #index" do
    it "assigns all companies as @companies" do
      get :index
      expect(assigns(:companies)).to eq([@company])
    end
  end

  describe "GET #show" do
    it "assigns the requested company as @company" do
      get :show, {:id => @company.to_param}
      expect(assigns(:company)).to eq(@company)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Company" do
        expect {
          post :create, {:company => valid_attributes}
        }.to change(Company, :count).by(1)
      end

      it "assigns a newly created company as @company" do
        post :create, {:company => valid_attributes}
        expect(assigns(:company)).to be_a(Company)
        expect(assigns(:company)).to be_persisted
      end

      it "checks users relationship with @company" do
        post :create, {:company => valid_attributes}
        expect(assigns(:company).users.first).to be_a(User)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved company as @company" do
        post :create, {:company => invalid_attributes}
        expect(assigns(:company)).to be_a_new(Company)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {name: 'Alahu'}
      }

      it "updates the requested company" do
        put :update, {:id => @company.to_param, :company => new_attributes}
        @company.reload
        expect(@company.name).to eq(new_attributes[:name])
      end

      it "assigns the requested company as @company" do
        put :update, {:id => @company.to_param, :company => valid_attributes}
        expect(assigns(:company)).to eq(@company)
      end
    end

    context "with invalid params" do
      it "assigns the company as @company" do
        put :update, {:id => @company.to_param, :company => invalid_attributes}
        expect(assigns(:company)).to eq(@company)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested company" do
      expect {
        delete :destroy, {:id => @company.to_param}
      }.to change(Company, :count).by(-1)
    end
  end

end