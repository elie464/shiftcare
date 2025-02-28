# Client Processor API

## Setup

To run the project please bundle and boot the server first

```
bundle
rails server
```

## How to call API

### Search

```
GET http://localhost:3000/api/search?query=Jan
```

### Duplicates

```
GET http://localhost:3000/api/duplicates
```

## Testing

To run tests

```
rails test
```

## Files of interest

clients_controller.rb:
https://github.com/elie464/shiftcare/blob/master/detailed/app/controllers/clients_controller.rb

clients_controller_test.rb
https://github.com/elie464/shiftcare/blob/master/detailed/test/clients_controller_test.rb

clients_processor.rb
https://github.com/elie464/shiftcare/blob/master/detailed/app/models/client_processor.rb

client_processor_test.rb
https://github.com/elie464/shiftcare/blob/master/detailed/test/client_processor_test.rb

## Thoughts/notes and assumptions

* Created Rails API only mode
* Test syntax uses a rspec-like notation but uses Minitest under the hood (minitest-spec-rails gem). From my experience this delivers the best combination of strong flexible rspec syntax with Minitest's speed 
* Use file_fixtures to store clients.json. Can be stored in DB and use models but felt too heavy for the purpose of this challenge
* Decided not to use a serializer like jbuilder to simplify the code for now
* Have added a default to query field ("full_name") but can be changed to email in the processor
* Have added a no duplicate file to test this case
* Chose not to use custom errors to return custom responses (403, 400 etc) as there is a proper way to write this as a module that will be too much for this exercise. So for now, just re-throwing 500 error with message from StandardError
  
