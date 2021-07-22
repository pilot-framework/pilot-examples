project = "gcp-react-example"

app "gcp-react-example" {
    build {
        use "yarn" {
            directory = "./gcp/react-example"
        }
    }

    deploy {
        use "pilot-cloud-cdn" {
            project = "gcp-react-example" # make sure this is project ID, not name
            bucket = "pilot-gcp-react-example" # this should be a unique bucket name
            region = "us-east1"
            directory = "./gcp/react-example/build"
        }
    }

    release {
        use "pilot-cloud-cdn" {}
    }
}
