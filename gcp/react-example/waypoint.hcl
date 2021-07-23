project = "gcp-react-example"

app "gcp-react-example" {
    build {
        use "yarn" {
            directory = "./gcp/react-example"
        }
    }

    deploy {
        use "pilot-cloud-cdn" {
            project = "gcp-react-example-319700" # make sure this is project ID, not name
            bucket = "pilot-gcp-react-example-025" # this should be a unique bucket name
            region = "us-east1"
            directory = "./gcp/react-example/build"
        }
    }

    release {
        use "pilot-cloud-cdn" {
            domain = "example029.dev"
        }
    }
}
