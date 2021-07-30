# The name of your project.
project = "gcpreact"

# Name of your application
app "frontend" {
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
      project = "pilot-321119"
      # This should be a globally unique bucket name
      bucket = "pilot-gcp-react-example"
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
        domain = "gcptest.grahamr.dev"
    }
  }
}