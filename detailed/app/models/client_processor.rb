class ClientProcessor
  def initialize(client_file)
    file = File.read(client_file)
    @clients = JSON.parse(file)
  end

  def search(query, field="full_name")
    raise StandardError, "query must not be empty" unless query.present?

    results = @clients.filter do |client|
      client[field].downcase.include?(query.downcase)
    end
  end

  def duplicates
    clients_by_email = @clients.each_with_object({}) do |client, acc|
      acc[client["email"]] ||= []
      acc[client["email"]].push(client)
    end

    results = clients_by_email.filter do |email, clients|
      clients.size > 1
    end
  end
end
