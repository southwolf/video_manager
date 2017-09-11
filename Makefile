test_native:
	rspec
	cd ./services/videos
	rspec
	cd ./services/comments
	rspec