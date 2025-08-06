# Install system dependencies
RUN apt-get update && apt-get install -y git

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of your code
COPY . .
