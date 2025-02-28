class ClientsController < ActionController::API
  rescue_from StandardError, :with => :handle_error

  def search
  	results = processor.search(params[:query])
  	render :json => results.to_json, :status => :ok
  end

  def duplicates
  	results = processor.duplicates
  	render :json => results.to_json, :status => :ok
  end

  private

  def processor
  	@processor ||= ClientProcessor.new(Rails.root.join("storage/clients.json"))
  end

  def handle_error(error)
    Rails.logger.error(error.message)
    render :json => { :error => error.message }, :status => 500
  end

end
