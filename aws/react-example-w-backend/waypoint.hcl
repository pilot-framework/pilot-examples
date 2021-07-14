# The name of your project. A project typically maps 1:1 to a VCS repository.
# This name must be unique for your Waypoint server. If you're running in
# local mode, this must be unique to your machine.
project = "react-todo"

# Labels can be specified for organizational purposes.
# labels = { "foo" = "bar" }

# An application to deploy - our React frontend.
app "todo-frontend" {
  # Config allows us to specify any environment variables we use in our apps
  config {
    env = {
      # make sure to update this to be the backend release URL
      API_BASE_URI = "some_url"
    }
  }
  # Build specifies how an application should be built. In this case,
  # we'll build using Yarn and output static files locally.
  build {
    use "yarn" {
        directory = "./client"
    }
  }

  # Deploy specifies where your application will be hosted. Since these are static files,
  # we'll be using Pilot's Cloudfront plugin, which stores the content on an S3 bucket
  deploy {
    use "pilot-cloudfront" {
      region = "us-east-1"
      # this will need to be a globally unique bucket name
      bucket = "pilot-todo-example"
    }
  }

  # Release specifies the final, if any, resting place of your application. For our Cloudfront
  # plugin, we need to specify that we want to use that to release the application as well to
  # provision the CDN distribution
  release {
    use "pilot-cloudfront" {}
  }
}

app "todo-backend" {
  config {
    env = {
      # retrieve your credentials via Atlas and replace the values below
      MONGO_USER = "your_user"
      MONGO_PASS = "your_pass"
      MONGO_DB = "your_db"
      MONGO_CLUSTER = "your_cluster"
    }
  }

  # Since our application is written in Typescript, we'll need to make sure we point to our
  # build directory (and make sure it's compiled beforehand as well)
  path = "server/dist/js"

  build {
    use "pack" {}

    registry {
      use "aws-ecr" {
        region = "us-east-1"
        repository = "pilot-react-todo-backend"
        tag = "latest"
      }
    }
  }

  deploy {
    use "aws-ecs" {
      region = "us-east-1"
      memory = "512"
    }
  }
}