# fraud-detection

This is rails based api application consist of two api end points
- `/classify` used to train the data
- `/check` used to identify the classified data (for example: good or bad)

# Requirements #
* ruby version 2.7.5

# Setup #
* bundle install
* To start the server use run rails s

# API Details #
## Classify API ##

This is a post type of API used to train the data.

**Parameter**

This API accepts the array of hashes as paramete. Each hash consist of 2 keys `category_name` and `values`. `category_name` is of string type and `values` is the array of strings and enclose all hashes as an array with the `data` key. Please have a look at the example data below.

```
{"data"=>                                         
  [{"category_name"=>"Good", "values"=>["Make time for exercise.", "Drink at least eight glasses of water a day.", "Do bodywork.", "Assign priorities to your tasks.", "Celebrate small victories."]},
   {"category_name"=>"Bad", "values"=>["Being Too Hard on Yourself", "Leaving Things to the Last Minute", "Focusing on the Negatives", "Blaming", "Sour Grapes"]}]} 
```

**Curl Request **

```
curl --location --request POST 'http://localhost:3000/api/v1/mobster/classify' \
--header 'Content-Type: application/json' \
--data-raw '{"data":[{"category_name":"Good","values":["Make time for exercise.","Drink at least eight glasses of water a day.","Do bodywork.","Assign priorities to your tasks.","Celebrate small victories."]},{"category_name":"Bad","values":["Being Too Hard on Yourself","Leaving Things to the Last Minute","Focusing on the Negatives","Blaming","Sour Grapes"]}]}'
```
**Response of the API**

The classify api return 422 (failure) and 200 (success) response code.

**Success Response**

```
{
    "success": true,
    "message": "Data has been trained successfully"
}
```

**Failure Response**

```
{
    "success": false,
    "message": "Something went wrong while traning the data"
}
```

## Check API ##

This is a get type of API used to judge the classified data.

**Parameter**

This API accepts a request parameters. Name of the parmaters is query and it is of the string type.

**Curl Request **

```
curl --location --request GET 'http://localhost:3000/api/v1/mobster/check?query=exercise'
```

**Response of the API**

The classify api return 404 (not_found / failure) and 200 (success) response code.

**Success Response**

```
{
    "success": true,
    "message": "Classification has been found",
    "classification": "Good"
}
```

**Failure Response**

```
{
    "success": false,
    "message": "Classification not found"
}
```

# Client Details #

## Client to call the classify API ##
```
{:data=>                            
  [{:category_name=>"Good", :values=>["Make time for exercise.", "Drink at least eight glasses of water a day.", "Do bodywork.", "Assign priorities to your tasks.", "Celebrate small victories."]},
   {:category_name=>"Bad", :values=>["Being Too Hard on Yourself", "Leaving Things to the Last Minute", "Focusing on the Negatives", "Blaming", "Sour Grapes"]}]}

client = ::Mobster::Client.new

client.classify(data)
```

## Client to call the check API ##

```
client = ::Mobster::Client.new
client.check(string_value)
```

# Test #

We have added test cases of services, API and client.

To run the test case please use `rspec` command.

# Work needs to be take care by other developers(colleague) #

* Added proper validation to both `Classify` and `check` API.
    
    * Add validation to strictly the incoming prameters for the both APIs.

    * Try to add more test-cases after add in the new validations.
