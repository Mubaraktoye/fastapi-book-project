# Use a base image with FastAPI and Uvicorn
FROM tiangolo/uvicorn-gunicorn-fastapi:python3.9

# Set the working directory inside the container
WORKDIR /app

# Copy the application code
COPY . /app

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Install Nginx
RUN apt update && apt install -y nginx

# Copy the Nginx configuration file (we will create this next)
COPY nginx.conf /etc/nginx/nginx.conf

# Expose ports
EXPOSE 80

# Start Nginx and FastAPI
CMD service nginx start && gunicorn -k uvicorn.workers.UvicornWorker -b 0.0.0.0:8000 main:app
