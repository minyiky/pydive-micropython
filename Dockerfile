FROM ubuntu AS builder

RUN mkdir /src

WORKDIR /src

RUN apt-get update && apt-get install -y git libsdl2-dev parallel libfreetype-dev librlottie-dev libavformat-dev libavcodec-dev libswscale-dev libavutil-dev

RUN apt-get install -y build-essential

COPY . /src

RUN git submodule update --init --recursive user_modules/lv_binding_micropython

RUN make -C ports/unix DEBUG=1 submodules

RUN make -B -j $(nproc) -C mpy-cross

RUN make -B -j $(nproc) -C ports/unix DEBUG=1 VARIANT=lvgl

FROM ubuntu AS runner

RUN apt-get update && apt-get install -y libsdl2-dev parallel libfreetype-dev librlottie-dev libavformat-dev libavcodec-dev libswscale-dev libavutil-dev

COPY --from=builder /src/ports/unix/build-lvgl/micropython /micropython

ENTRYPOINT ["/micropython"]
