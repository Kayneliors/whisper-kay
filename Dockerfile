FROM python:3.10-slim

# Install system dependencies
RUN apt-get update && apt-get install -y git

# Set working directory
WORKDIR /app

# Copy requirements and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of your code
COPY . .

# Set entrypoint or command
CMD ["python", "app.py"]
