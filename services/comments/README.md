# Comments Service
Rails Engine / GEM
Manages CRUD operations for video comments resources.
Data is persisted to [MongoDb](https://www.mongodb.com/)

## Installation
Add to your Gemfile

```ruby
gem 'comments', path: 'path_to_repo'
```

then

```bash
$ bundle
```

## Configuration
Your client must have the `mongoid.yml` file in its `./config` directory
Check out the sample file under `/spec/dummy/config/mongoid.yml`
The app needs to have a `videos` client setup under the `clients` section.
All data will be persisted to the database defined therein.

## running tests

```bash
$ rspec
```

## Usage

Instantiate a client:

```ruby
client = Comments::Client.new
```

### Create a Comment for a Video

```ruby
comment_params = {
  video_id: '62448771-f561-46f4-94dd-948b71494554',
  commenter_id: '5607eca8-f531-4745-8e70-48dcf0a30d01',
  text: 'Lorem Ipsum Dolor'
}
response = client.create(comment_params)
```

```bash
$ response

{
  status: 200,
  body: {
    "_id" : "72213933-a740-4af6-ac93-2e5940d972b3",
    "video_id": "62448771-f561-46f4-94dd-948b71494554",
    "commenter_id" : "5607eca8-f531-4745-8e70-48dcf0a30d01",
    "text: "Lorem Ipsum Dolor",
    "created_at" : "2017-09-06 02:57:34 UTC",
    "updated_at" : "2017-09-06 02:57:34 UTC"
  }
}
```

### Get a Comment

```ruby
client.get('comment_id')
```

### Get all Comments for a Video

```ruby
response = client.get_for_video('62448771-f561-46f4-94dd-948b71494554')
```

```bash
$ response

{
  status: 200,
  body: [
    {
      "_id" : "72213933-a740-4af6-ac93-2e5940d972b3",
      "video_id": "62448771-f561-46f4-94dd-948b71494554",
      "commenter_id" : "5607eca8-f531-4745-8e70-48dcf0a30d01",
      "text: "Lorem Ipsum Dolor",
      "created_at" : "2017-09-06 02:57:34 UTC",
      "updated_at" : "2017-09-06 02:57:34 UTC"
    },
    {
      "_id" : "b950550a-e75e-488f-a770-fbffa7b0dbf5",
      "video_id": "62448771-f561-46f4-94dd-948b71494554",
      "commenter_id" : "5607eca8-f531-4745-8e70-48dcf0a30d01",
      "text: "consectetur adipiscing elit",
      "created_at" : "2017-09-07 02:57:34 UTC",
      "updated_at" : "2017-09-07 02:57:34 UTC"
     }
  ]
}
```

### Update a Comment

```ruby
client.update('comment_id', comment_params)
```

### Delete a Comment

```ruby
client.delete('comment_id')
```

### Delete all Comments for a video

```ruby
client.delete_for_video('video_id')
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
    "video_id": ["can't be blank"]
  }
}
```
