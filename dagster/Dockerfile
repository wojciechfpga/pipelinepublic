FROM python:3.9-slim

WORKDIR /opt/dagster/app

# Install Dagster and dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy Dagster code
COPY pipeline.py .

# Set environment variables
ENV DAGSTER_HOME=/opt/dagster/app

# Expose Dagster port
EXPOSE 3000

# Run Dagster
CMD ["dagster", "dev", "-h", "0.0.0.0", "-p", "3000"]