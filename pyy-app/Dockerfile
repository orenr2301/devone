FROM python:3.9

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV MONGO_URL="mongodb://mongodb:27017"
ENV DB_NAME="docker_db"

ENV MONGO_INITDB_ROOT_USERNAME=admin
ENV MONGO_INITDB_ROOT_PASSWORD=admin

EXPOSE 80

CMD ["python", "app.py"]

###comment