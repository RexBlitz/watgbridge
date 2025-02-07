# Build Stage
FROM golang:1.22.3-alpine3.19 AS build

# Install dependencies
RUN apk --no-cache add gcc g++ make git libwebp-tools ffmpeg imagemagick

# Set working directory
WORKDIR /app

# Copy Go module files and download dependencies
COPY go.mod go.sum ./
RUN go mod download

# Copy the application source code
COPY . .

# Build the application
RUN go build -o watgbridge

# Runtime Stage
FROM alpine:3.19

# Install necessary runtime dependencies
RUN apk --no-cache add tzdata libwebp-tools ffmpeg imagemagick

# Set working directory
WORKDIR /app

# Copy the built application from the builder stage
COPY --from=build /app/watgbridge .

# Copy the config file (ensure it's included in the Docker build)
COPY config.yaml /app/config.yaml

# Expose the necessary port
EXPOSE 3000

# Run the application
CMD ["./watgbridge"]
