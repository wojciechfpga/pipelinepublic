FROM python:3.9-slim

WORKDIR /usr/app/dbt

# Install dbt and dbt-clickhouse
RUN pip install --no-cache-dir dbt-core==1.5.0 dbt-clickhouse==1.5.0

# Copy dbt project files
COPY . .

CMD ["dbt", "run", "--profiles-dir", "."]