FROM python:3.9

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV MONGO_URL="mongodb://mongodb:27017"
ENV DB_NAME="docker_db"

EXPOSE 80

CMD ["python", "app.py"]
##nosdte  ssdds s ##
