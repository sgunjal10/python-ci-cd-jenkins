# Lightweight Python image
FROM python:3.10-slim

# Set working directory inside container
WORKDIR /app

# Copy dependency file
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy app and tests
COPY app/ ./app
COPY tests/ ./tests

# Default command: run tests
CMD ["pytest", "tests/"]