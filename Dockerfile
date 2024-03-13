FROM arm32v7/python:3-alpine

WORKDIR /Development/flutter/flutter_jukebox/build/web

COPY ./build/web .
COPY ./webserver.py .

# CMD [ "python", "webserver.py" ]
CMD [ "python", "-m", "http.server", "8000" ]