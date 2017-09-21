# Activity Stream Service
Rails Engine / GEM
Manages CRUD operations for activity streams.
Data is persisted to [MongoDb](https://www.mongodb.com/)

## Installation
Add to your Gemfile

```ruby
gem 'activity_stream', path: 'path_to_repo'
```

then

```bash
$ bundle
```

## Configuration
Your client must have the `mongoid.yml` file in its `./config` directory
Check out the sample file under `/spec/dummy/config/mongoid.yml`
The app needs to have a `activity_stream` client setup under the `clients` section.
All data will be persisted to the database defined therein.

## running tests

```bash
$ rspec
```

## Usage

Instantiate a client:

```ruby
client = ActivityStream::Client.new
```