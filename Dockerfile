FROM python:3.9-slim-bullseye
RUN apt-get update && apt-get install -y wget \
    && apt-get install -y --no-install-recommends gcc libffi-dev libc6-dev ffmpeg aria2 python3-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY . /app/
WORKDIR /app/
RUN pip3 install --no-cache-dir --upgrade pip \
    && pip3 install --no-cache-dir --upgrade -r requirements.txt \
    && python3 -m pip install -U yt-dlp
CMD ["sh", "-c", "gunicorn app:app & python3 main.py"]
