# Use the slim Ruby base image
FROM ruby:2.7-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the Gemfile and Gemfile.lock first
COPY Gemfile Gemfile.lock ./

# Install necessary dependencies for building native extensions
# (modify this step based on your specific gem dependencies)
RUN apt-get update -qq && apt-get install -y build-essential

# Install gems
RUN bundle install

# Copy the rest of your application into the container
COPY . .

# Your other Docker commands, e.g., setting the default command for the container
CMD ["bundle", "exec", "ruby", "/app/action.rb"]
