project = "gcp-react-example"

app "gcp-react-example" {
    build {
        use "yarn" {
            directory = "./"
        }
    }

    deploy {
        use "pilot-gcp-cdn" {
            project = "gcp-react-example" # make sure this is project ID, not name
            bucket = "pilot-gcp-react-example" # this should be a unique bucket name
            region = "us-east1"
        }
    }

    release {
        use "pilot-gcp-cdn" {}
    }
}