# The name of your project.
project = "delete-test"

# Name of your application
app "frontend" {
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
      bucket = "pilot-delete-testing"
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