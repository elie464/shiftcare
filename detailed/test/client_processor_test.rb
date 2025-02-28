require "test_helper"

class ClientProcessorTest < ActiveSupport::TestCase

  let(:json_path) { file_fixture("clients.json").to_path }

  describe "#search" do
    context "when searching by name" do
      it "returns clients partially matched by full name" do
        processor = ClientProcessor.new(json_path)
        results = processor.search("Jane")

        expect(results).wont_be :blank?
        results.each do |result|
          expect(result["full_name"]).must_include "Jane"
        end
      end

      context "when searching by query that does not match" do
        it "returns no results" do
          processor = ClientProcessor.new(json_path)
          results = processor.search("notmatching")

          expect(results).must_be :blank?
        end
      end

      context "when query is blank" do
        it "throws error" do
          processor = ClientProcessor.new(json_path)

          error = assert_raises StandardError do
            results = processor.search(nil)
          end
          expect(error.message).must_equal "query must not be empty"
        end
      end

      context "when searching by email" do
        it "returns clients partially matched by email" do
          processor = ClientProcessor.new(json_path)
          results = processor.search("yahoo", "email")

          expect(results).wont_be :blank?
          results.each do |result|
            expect(result["email"]).must_include "yahoo"
          end
        end
      end
    end
  end

  describe "#duplicates" do
    context "when checking for duplicates" do
      it "returns duplicates with same email" do
        processor = ClientProcessor.new(json_path)
        results = processor.duplicates

        expect(results).wont_be :blank?
        results.each do |email, clients|
          expect(clients.size).must_be :>, 1
        end
      end

      context "when searching by query that does not match" do
        it "returns no results" do
          json_path = file_fixture("clients_no_duplicates.json").to_path
          processor = ClientProcessor.new(json_path)
          results = processor.duplicates

          expect(results).must_be :blank?
        end
      end
    end
  end
end
