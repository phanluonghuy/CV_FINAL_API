# Use an official Python base image
FROM python:3.10-slim

# Set the working directory in the container
WORKDIR /app

# Copy the notebook and any necessary files into the container
COPY CompareFaceAPI.ipynb /app/
COPY siamese_model_weights.h5 /app/

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3-dev \
    libgl1-mesa-glx \
    libglib2.0-0 \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Python libraries
RUN pip install --no-cache-dir \
    notebook \
    paddleocr \
    opencv-python-headless \
    numpy \
    flask \
    pyngrok \
    matplotlib \
    tensorflow \
    mtcnn \
    werkzeug

# Expose the port Jupyter Notebook will run on
EXPOSE 8888

# Command to run Jupyter Notebook
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
