# 3.12, not newer: pydub needs the audioop module, which Python 3.13 removed
FROM python:3.12-slim

# Work inside /app in the container
WORKDIR /app

# Install dependencies first, so Docker can reuse this layer when only code changes
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the app (.dockerignore keeps out the junk)
COPY . .

# The app listens on port 5000
EXPOSE 5000

# app.py hardcodes port 3000, so start Flask directly on 5000.
# --host=0.0.0.0 makes it reachable from outside the container.
CMD ["flask", "run", "--host=0.0.0.0", "--port=5000"]
