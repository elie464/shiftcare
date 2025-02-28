require "test_helper"

class ClientsControllerTest < ActionDispatch::IntegrationTest

  describe "GET search" do
    context "when searching by name" do
      it "returns clients partially matching full name with query" do
        get "/api/search", :params => { :query => "Jan"}

        expect(response.status).must_equal 200
        json_response = JSON.parse(response.body)

        expect(json_response.count).must_equal 3
        json_response.each do |client|
          expect(client["full_name"]).must_include "Jan"
        end
      end
    end

    context "when searching by query that does not match" do
      it "returns no results" do
        get "/api/search", :params => { :query => "notmatching"}

        expect(response.status).must_equal 200
        json_response = JSON.parse(response.body)

        expect(json_response).must_be :empty?
      end
    end

    context "when query is not provided" do
      it "returns 500 error with message" do
        get "/api/search"

        expect(response.status).must_equal 500
        json_response = JSON.parse(response.body)

        expect(json_response["error"]).must_equal "query must not be empty"
      end
    end
  end

  describe "GET duplicates" do
    context "when checking for duplicates" do
      it "returns clients with duplicate emails" do
        get "/api/duplicates"

        expect(response.status).must_equal 200
        json_response = JSON.parse(response.body)

        expect(json_response.count).must_equal 2
        json_response.each do |email, clients|
          expect(clients.size).must_be :>, 1
        end
      end
    end
  end

end
