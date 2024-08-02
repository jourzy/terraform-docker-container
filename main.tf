# Define the Terraform block to specify required providers and their versions
terraform {
  required_providers {
    # Use the Docker provider from the 'kreuzwerker/docker' source
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"  # Specify the version constraint for the Docker provider
    }
  }
}

# Configure the Docker provider with the host
provider "docker" {
  # Specify the Docker daemon host to connect to (using Unix socket)
  host = "unix:///var/run/docker.sock"
}

# Define a Docker image resource for the NGINX image
resource "docker_image" "nginx" {
  # Name of the Docker image to use
  name = "nginx"
  # Specify whether to keep the image locally after container removal
  keep_locally = false  # Do not keep the image locally after container destruction
}

# Define a Docker container resource using the NGINX image
resource "docker_container" "nginx" {
  # Reference the Docker image resource to get the image ID
  image = docker_image.nginx.image_id
  # Name of the Docker container
  name  = "tutorial"

  # Define the port mappings for the container
  ports {
    # Map the internal port 80 (inside the container) to the external port 8000 (on the host)
    internal = 80
    external = 8000
  }
}

