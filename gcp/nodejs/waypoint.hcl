# The name of your project.
project = "gcpbackend"

# See the following for additional information on Waypoint's built-in GCR plugin:
# https://www.waypointproject.io/plugins/google-cloud-run

app "backend" {
  # The application entrypoint in relation to the root of your project/repo
  # example: path = "./sub_dir/my_app"
  path = "./"

  build {
    # Builds an image based off of your source code using Cloud Native Buildpacks
    use "pack" {}

    registry {
      # Pushes built image to Cloud Container Registry
      use "docker" {
        image = "gcr.io/pilot-321119/backend"
        tag   = "latest"
      }
    }
  }

  deploy {
    # Deploys application to Google Cloud Run
    use "google-cloud-run" {
      project  = "pilot-321119"
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