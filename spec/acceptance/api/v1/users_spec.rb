require 'acceptance_helper'      # We require acceptance specs configuration from spec/acceptance_helper.rb.

resource 'Users' do
  # Headers that will be sent in every request. 
  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'

  # Describe URL and parameters for a cars list request.
  # As a second parameter we pass request description. 
  # REST APIs requests may have the same paths, but differ by HTTP method, 
  # we extract a path to a parent block, so descendant blocks can describe each method 
  route '/api/v1/users', 'Users Collection' do

    # Testing GET /api/v1/users request. 
    get 'Returns all users' do
      # Creation of some test data.
      let!(:user1) { User.create(email: 'admin7@example.com', password: 'admin@example.com', password_confirmation: 'admin@example.com') }
      let!(:user2) { User.create(email: 'admin8@example.com', password: 'admin@example.com', password_confirmation: 'admin@example.com') }

      # Let’s test two cases: 
      context 'without page params' do
        example_request 'Get a list of all cars ordered DESC by year' do
          expect(status).to eq(200)
          expect(response_body).to eq(json_collection([user1, user2]))
        end
      end
    end
  end

  route '/api/v1/users', 'Creation of user' do
    # Attribute defines what attributes you can send in the request body.
    # Option :required makes the parameter mandatory. 
    attribute :email, "User name"
    attribute :password, "User password"
    attribute :password_confirmation, 'User password confirmation'

    post 'Add a car' do
      let(:email)  { 'passat@gamil.com' }
      let(:password)  { 111111 }
      let(:password_confirmation) { 111111 }
      let(:request) { { user: { email: email, password: password, password_confirmation: password_confirmation } } }

      context 'with a valid brand' do
        example 'Creating a car' do
          do_request(request)
          expect(response_body).to eq(json_item(User.last))
          expect(status).to eq(200)
        end
      end
    end
  end

  protected

  def json_collection(collection)
    ActiveModel::Serializer::CollectionSerializer.new(collection, serializer: Api::V1::UserSerializer).to_json
  end

  def json_item(item)
    Api::V1::UserSerializer.new(item).to_json
  end
end