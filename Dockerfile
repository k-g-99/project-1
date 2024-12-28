# Use the official Python image
FROM python:3.12-slim

# Set the working directory inside the container
WORKDIR /app

# Copy requirements file and application code
COPY requirements.txt ./ 
COPY app.py ./ 

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port Streamlit will run on
EXPOSE 8501

# Run the Streamlit app
CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]
