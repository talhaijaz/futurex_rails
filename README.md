# FutureXRails
Welcome to a ruby client that interacts with the FutureX API.

Comments, PR's are more than welcome. I would love to hear any ideas or suggestions.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'futurex_rails'
```

And then execute:
```bash
$ bundle
```
## Usage
This plugin supports creation of courses, fetching of options for entities, get progress of enrollement, learners by content providers & accomplishment certifcates

1. To setup get the client_id and client_secret from FutureX.

2. After step 1 you will have client_id and client_secret.

3. Call the acccess Token Api with these params

        params = {grant_type: 'client_credentials',
                  client_id: 'client_id',
                  client_secret: 'client_secret'}

    FutureXRails.new(params).fetch_access_token

4. For all other apis you can call like this
        params = {access_token: 'access token fetched from Step 3',
                  entity: 'CreateCourse',
                  courseId: '2',
                  name: 'Course A',
                  description: 'Course Description'}

        FutureXRails.new(params).fetch_or_create_entity_data

## Note
1. Supported entities are CreateCourse, OptionsForEntityFields, EnrollmentByProgress, LearnersByContentProvider, AccomplishmentCertificates