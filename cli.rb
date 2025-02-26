require 'json'

class ClientProcessor
  def initialize(client_file)
    file = File.read(client_file)
    @clients = JSON.parse(file)
  end

  def search(query, field="full_name")
    results = @clients.filter do |client|
      client[field].downcase.include?(query.downcase)
    end
    print_results(results)
  end

  def duplicates
    clients_by_email = @clients.each_with_object({}) do |client, acc|
      acc[client["email"]] ||= []
      acc[client["email"]].push(client)
    end

    results = clients_by_email.values.filter do |clients|
      clients.size > 1
    end

    print_results(results)
  end

  private

  def print_results(results)
    puts results.any? ? results : "No Results Found"
  end
end

client_processor = ClientProcessor.new('clients.json')
command = ARGV[0]

case command
when 'search'
  client_processor.search(ARGV[1])
when 'duplicates'
  client_processor.duplicates
else
  puts "Unknown command: #{command}"
end
