# Use the slim Ruby base image
FROM ruby:3.2-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy the Gemfile and Gemfile.lock first
COPY Gemfile Gemfile.lock ./

# Install gems
RUN apk add --update build-base libffi-dev

RUN bundle install

# Copy the rest of your application into the container
COPY . .

CMD ["/app/action.sh"]
