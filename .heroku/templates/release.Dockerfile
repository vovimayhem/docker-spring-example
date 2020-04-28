FROM docker.pkg.github.com/${GITHUB_ACTOR}/${GITHUB_REPOSITORY}/spring-demo:latest

CMD [ "echo", "'executing database migration'..."]