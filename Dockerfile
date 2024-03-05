FROM python:3.11-slim AS builder

WORKDIR /app

COPY requirements.txt /app/

COPY app.py /app/

COPY mongo.py /app/

COPY service/ /app/service/

COPY model/ /app/model/

COPY dao/ /app/dao/

RUN pip install --no-cache-dir -r requirements.txt

FROM python:3.11-slim

ENV MONGO_IP localhost
ENV MONGO_PORT 27017

WORKDIR /app

COPY --from=builder /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages
COPY --from=builder /app /app

EXPOSE 5000
EXPOSE 27017

CMD ["python", "app.py"]
