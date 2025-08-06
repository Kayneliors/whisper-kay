FROM python:3.10-slim

# Install basic dependencies
RUN apt-get update && apt-get install -y \
    git ffmpeg libsndfile1 \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy code
COPY . /app

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Start server
CMD ["python", "handler.py"]
