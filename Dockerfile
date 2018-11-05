FROM nvidia/cuda:9.0-devel-ubuntu16.04
ARG DEBIAN_FRONTEND=non-interactive

# ------------------------------------------------------------------
# update & requirements
# ------------------------------------------------------------------

RUN apt-get update && apt-get install -y \
    git \
    cmake \
    build-essential \
    vim \
    libboost-program-options-dev \
    libboost-filesystem-dev \
    libboost-graph-dev \
    libboost-regex-dev \
    libboost-system-dev \
    libboost-test-dev \
    libeigen3-dev \
    libsuitesparse-dev \
    libfreeimage-dev \
    libgoogle-glog-dev \
    libgflags-dev \
    libglew-dev \
    qtbase5-dev \
    libqt5opengl5-dev \
    libcgal-dev \
    libcgal-qt5-dev\
    libatlas-base-dev \
    libsuitesparse-dev

# ------------------------------------------------------------------
# ceres
# ------------------------------------------------------------------

RUN git clone https://ceres-solver.googlesource.com/ceres-solver \
    /software/ceres && \
    cd /software/ceres && \
    git checkout $(git describe --tags) && \
    mkdir -p /software/ceres/build && cd /software/ceres/build && \
    cmake .. -DBUILD_TESTING=OFF -DBUILD_EXAMPLES=OFF && \
    make -j"$(nproc)" && \
    make install  && \
    make clean

# ------------------------------------------------------------------
# colmap
# ------------------------------------------------------------------

RUN git clone https://github.com/colmap/colmap.git \
    /software/colmap && \
    cd /software/colmap && \
    git checkout dev && \
    mkdir build && \
    cd build && \
    cmake ..  && \
    make -j"$(nproc)" && \
    make install  && \
    make clean

# ------------------------------------------------------------------
# cleanup
# ------------------------------------------------------------------

RUN apt-get purge -y cmake && apt-get autoremove -y
RUN rm -rf /software
RUN mkdir /project
WORKDIR /
