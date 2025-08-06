FROM python:3.10-slim

# Install git and other dependencies
RUN apt-get update && apt-get install -y git ffmpeg && apt-get clean

# Set workdir
WORKDIR /app

# Copy requirements
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy rest of the code
COPY . .

# Expose port (optional, if running server)
EXPOSE 8000

# Start the app (adjust if you're running something else)
CMD ["python", "main.py"]
