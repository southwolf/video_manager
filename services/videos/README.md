# Videos Service
Rails Engine / GEM
Manages CRUD operations for video resources.
Data is persisted to [MongoDb](https://www.mongodb.com/)

## Installation
Add to your Gemfile

```ruby
gem 'videos', path: 'path_to_repo'
```

then

```bash
$ bundle
```

## Configuration
Your client must have the `mongoid.yml` file in its `./config` directory
Check out the sample file under `/spec/dummy/config/mongoid.yml`
The app needs to have a `comments` client setup under the `clients` section.
All data will be persisted to the database defined therein.

## running tests

```bash
$ rspec
```

## Usage

Instantiate a client:

```ruby
client = Videos::Client.new
```

### Create a Video

```ruby
video_params = { title: 'foo', description: 'bar' }
response = client.create(video_params)
```

```bash
$ response

{
  status: 200,
  body: {
    "_id" : "62448771-f561-46f4-94dd-948b71494554",
    "title" : "foo",
    "description: "bar",
    "created_at" : "2017-09-06 02:57:34 UTC",
    "updated_at" : "2017-09-06 02:57:34 UTC"
  }
}
```

### Get a Video

```ruby
client.get('video_id')
```

### Update a Video

```ruby
client.update('video_id', video_params)
```

### Delete a Video

```ruby
client.delete('video_id')
```

### Errors

not_found, validation or server errors will be responded with their appropriate status codes and payloads

```ruby
{
  status: 404,
  body: {
    errors: 'not found'
  }
}
```

```ruby
{
  status: 422,
  body: {
    "title": ["can't be blank"]
  }
}
```
