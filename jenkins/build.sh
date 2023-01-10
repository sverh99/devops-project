docker login
docker buildx build --platform linux/amd64,linux/arm64 . -t sverh123/jenkins-sv --push
