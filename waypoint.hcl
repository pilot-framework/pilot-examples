# The name of your project.
project = "pilot-examples"

# Name of your application
app "aws-frontend" {
  build {
    # The template uses a default build plugin provided by Pilot
    # to build your static files for deployment
    use "yarn" {
      # The application entrypoint in relation to the root of your project/repo
      # example: directory = "./sub_dir/my_app"
      directory = "./aws/react-example"
    }
  }

  deploy {
    # The template uses a default deploy plugin provided by Pilot
    # to deploy your static assets to a S3 bucket with static web hosting enabled
    use "pilot-cloudfront" {
      # Your chosen AWS region
      region = "us-east-1"
      # This should be a globally unique bucket name
      bucket = "pilot-examples-repository"
      # Location of build files in relation to root of project/repo
      directory = "./aws/react-example/build/"
    }
  }

  release {
    # The template uses a default release plugin provided by Pilot
    # to deploy your static site to a Cloudfront distribution
    use "pilot-cloudfront" {}
  }
}

# See the following for additional information on Waypoint's built-in ECS plugin:
# https://www.waypointproject.io/plugins/aws-ecs

app "pilot-aws-nodejs" {
  # The application entrypoint in relation to the root of your project/repo
  # example: path = "./sub_dir/my_app"
  path = "./aws/nodejs"

  build {
    # Builds an image based off of your source code using Cloud Native Buildpacks
    use "pack" {}
    registry {
      # ECR registry to push built images to
      use "aws-ecr" {
        region     = "us-east-1"
        repository = "pilot-examples"
        tag        = "latest"
      }
    }
  }

  deploy {
    # ECS Deployment cluster parameters
    # Doubles as the release platform
    use "aws-ecs" {
      region = "us-east-1"
      memory = "512"
    }
  }
}

# Name of your application
app "gcp-frontend" {
  build {
    # The template uses a default build plugin provided by Pilot
    # to build your static files for deployment
    use "yarn" {
      # The application entrypoint in relation to the root of your project/repo
      # example: directory = "./sub_dir/my_app"
      directory = "./gcp/react-example"
    }
  }

  deploy {
    # The template uses a default deploy plugin provided by Pilot
    # to deploy your static assets to a Cloud Storage bucket
    use "pilot-cloud-cdn" {
      # Your GCP Project ID - this will be the default Project ID if used with Pilot
      project = "gcp-pilot-testing"
      # This should be a globally unique bucket name
      bucket = "pilot-examples-repository"
      # Your chosen GCP region
      region = "us-east1"
      # Location of build files in relation to root of project/repo
      directory = "./gcp/react-example/build"
    }
  }

  release {
    # The template uses a default release plugin provided by Pilot
    # to deploy your static site to a Cloud CDN distribution
    use "pilot-cloud-cdn" {
        domain = "example.domain.com"
    }
  }
}

# See the following for additional information on Waypoint's built-in GCR plugin:
# https://www.waypointproject.io/plugins/google-cloud-run

app "pilot-gcp-nodejs" {
  # The application entrypoint in relation to the root of your project/repo
  # example: path = "./sub_dir/my_app"
  path = "./gcp/nodejs"

  build {
    # Builds an image based off of your source code using Cloud Native Buildpacks
    use "pack" {}

    registry {
      # Pushes built image to Cloud Container Registry
      use "docker" {
        image = "gcr.io/gcp-pilot-testing/pilot-gcp-nodejs"
        tag   = "latest"
      }
    }
  }

  deploy {
    # Deploys application to Google Cloud Run
    use "google-cloud-run" {
      project  = "gcp-pilot-testing"
      location = "us-east1"

      capacity {
        memory                     = 128
        cpu_count                  = 1
        max_requests_per_container = 10
        request_timeout            = 300
      }

      auto_scaling {
        max = 2
      }
    }
  }

  release {
    # Releases application on Google Cloud Run
    use "google-cloud-run" {}
  }
}