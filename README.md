# Terraform Docker NGINX

This GitHub repository demonstrates how to use Terraform to automate the deployment of a Docker container running NGINX. The repository contains a Terraform configuration that defines a Docker provider, pulls the official NGINX Docker image, and runs an NGINX container accessible on port 8000 of the host machine.

## Prerequisites

Before running the Terraform configuration, ensure you have the following installed:

- Terraform (v1.0 or higher)
- Docker (including the Docker daemon running)
- Git

## Usage

1. Clone the repository

```git clone https://github.com/jourzy/terraform-docker-container.git```

```cd terraform-docker-nginx```

2. Initialize the Terraform working directory

Initialize Terraform to download the required providers:

```terraform init```

3. Preview the infrastructure changes

You can preview the changes that will be applied to your Docker environment by running:

```terraform plan```

4. Apply the configuration

Deploy the NGINX container using Terraform:

```terraform apply```

5. Access the NGINX container

After the container is running, you can access NGINX by navigating to http://localhost:8000 in your browser.

6. Destroy the container

If you want to remove the NGINX container and any associated resources, run:

```terraform destroy```

Confirm with ```yes``` when prompted.

## Explanation of ```main.tf```

- **Providers:** The configuration uses the Docker provider, sourced from kreuzwerker/docker, to manage Docker resources.

```
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}
```

- **Docker Image:** The docker_image resource pulls the official NGINX image from Docker Hub.

```
resource "docker_image" "nginx" {
  name = "nginx"
  keep_locally = false
}
```

- **Docker Container:** The docker_container resource creates and runs a Docker container using the pulled NGINX image. The container maps port 80 inside the container to port 8000 on the host.

```
resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "tutorial"

  ports {
    internal = 80
    external = 8000
  }
}
```
## Notes

- Ensure that Docker is running, and the Docker daemon is accessible via Unix socket (```/var/run/docker.sock```), as this is how Terraform connects to Docker.
- You can modify the port mappings in the Terraform file if you need to use a different external port.

## License

This project is licensed under the MIT License. See the [LICENSE](https://opensource.org/license/MIT) file for details.



Feel free to contribute or raise issues in the repository to improve the project!



