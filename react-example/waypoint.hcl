project = "react-example"

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
}