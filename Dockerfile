# Stage 1: Build stage
FROM alpine:latest AS build

# Install necessary tools
RUN apk add --no-cache gcc musl-dev

# Set the working directory
WORKDIR /app

# Copy the C source file
COPY idle.c ./

# Universal compile command for all architectures
RUN gcc -Os -nostartfiles -ffreestanding -fno-asynchronous-unwind-tables -fno-stack-protector -static -s -Wl,--gc-sections -fdata-sections -ffunction-sections -o idle idle.c && \
    strip --strip-all idle

# Stage 2: Minimal final image
FROM scratch

# Copy the compiled binary from the build stage
COPY --from=build /app/idle /idle

# Allow idle to be found in PATH
ENV PATH=/

# Set the binary as the entrypoint
ENTRYPOINT ["/idle"]
