# Use the official Python image as a base
FROM python:3.11

# Set the working directory in the container
WORKDIR /app

# Install curl and dependencies required for Poetry installation
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install Poetry
RUN curl -sSL https://install.python-poetry.org | POETRY_HOME=/opt/poetry python3.11 -

# Add Poetry to the PATH
ENV PATH="/opt/poetry/bin:${PATH}"

# Copy only pyproject.toml to leverage Docker cache
COPY pyproject.toml poetry.lock* /app/

# Install project dependencies
RUN poetry install

# Copy the rest of the application
COPY .. /app

# Expose the Flask port
EXPOSE 5000

# Command to run the Flask application
CMD ["poetry", "run", "python", "app/app.py"]