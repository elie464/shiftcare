require 'json'

class ClientProcessor
  def initialize(client_file)
    file = File.read(client_file)
    @clients = JSON.parse(file)
  end

  def search(query)
    results = @clients.filter do |client|
      client["full_name"].downcase.include?(query.downcase)
    end
    print_results(results)
  end

  def duplicates
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
when 'help'
  puts "Usage: ruby cli.rb <command> <argument>"
  puts "Commands:"
  puts "  search <query>: Search clients by name"
  puts "  duplicates: Find duplicate emails"
else
  puts "Unknown command: #{command}"
end
