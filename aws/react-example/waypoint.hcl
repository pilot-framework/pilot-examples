project = "react-example"

runner {
    enabled = true
}

app "react-example" {
    build {
        use "yarn" {
            directory = "./"
        }
    }

    deploy {
        use "pilot-cloudfront" {
            region = "us-east-1"
            bucket = "pilot-react-example" # this should be a unique bucket name
        }
    }

    release {
        use "pilot-cloudfront" {}
    }
}
