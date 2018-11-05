# Docker image for COLMAP - NVIDIA GPU

This Dockerfile runs [COLMAP](https://github.com/colmap/colmap) with CUDA, allowing dense reconstruction. COLMAP supports Structure from Motion (SfM), Multi-View Stereo (MVS). It uses Ceres-Solver for bundle adjustment.

## Requirements

The image is built on CUDA 9.0, so the host machine must have CUDA >= 9.0.

## Documentation

Only the command line functions are available. The documentation is available at <https://colmap.github.io/.>

The NVIDIA runtime is required (nvidia-docker v2), instructions here: <https://github.com/NVIDIA/nvidia-docker.>

## Examples

To build the image from the Dockerfile.

    sudo docker build --no-cache  -t dgrnwd/colmap:gpu .

Connecting a host project directory to the container. Ensure the host project directory has an images sub directory.

    sudo docker run --runtime=nvidia  \
    -v /host/project:/project \
    -it dgrnwd/colmap:gpu bash

Running the automatic reconstructor.

    colmap automatic_reconstructor \
        --workspace_path /project \
        --image_path /project/images
