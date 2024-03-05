FROM python:3.11-slim AS builder

WORKDIR /app

COPY ./ .

RUN pip install -r requirements.txt

FROM builder AS runner

COPY . .

EXPOSE 5000

ENV MONGO_IP="mi-mongo"
ENV MONGO_PORT="27017"

CMD ["python", "app.py"]
