# Stage 1: Build the Go application
FROM golang:1.22.3-alpine3.19 AS build

# Install required dependencies
RUN apk --no-cache add gcc g++ make git libwebp-tools ffmpeg imagemagick

# Set the working directory inside the container
WORKDIR /app

# Copy Go module files and download dependencies
COPY go.mod go.sum ./
RUN go mod download

# Copy the source code and build the Go application
COPY . .
RUN go build -o watgbridge

# Stage 2: Create a lightweight final container
FROM alpine:3.19

# Install runtime dependencies
RUN apk --no-cache add tzdata libwebp-tools ffmpeg imagemagick

# Set the working directory inside the container
WORKDIR /app

# Copy the built binary from the build stage
COPY --from=build /app/watgbridge .

# Expose the application's port (if required)
EXPOSE 3000

# Start the application
CMD ["./watgbridge"]
