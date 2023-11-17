FROM arm32v7/python:3-alpine

WORKDIR /Development/flutter/flutter_jukebox/build/web

COPY ./build/web .

CMD [ "python", "-m", "http.server", "8000" ]