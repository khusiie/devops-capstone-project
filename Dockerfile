FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy requirements first for caching
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application source code
COPY service ./service
COPY tests ./tests
COPY setup.cfg .
COPY .flaskenv .
COPY . .

# Expose the service port
EXPOSE 8080

# Run the service
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "service.routes:app"]
