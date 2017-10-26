# Container Environment for P4 Development

## Building the images

There are two images with through Dockerfiles:
  1. An image for the P4 reference compiler
  2. An image for the GRPC-enabled simple switch

Build the images using:

    make

## Running the images

P4 Compiler:

    p4c/p4c
