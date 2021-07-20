project = "react-example"

app "react-example" {
    build {
        use "yarn" {
            # need to specify with the way waypoint handles remote repo cloning
            directory = "./aws/react-example"
        }
    }

    deploy {
        use "pilot-cloudfront" {
            region = "us-east-1"
            bucket = "pilot-react-example" # this should be a unique bucket name
            directory = "./aws/react-example/build"
        }
    }

    release {
        use "pilot-cloudfront" {}
    }
}
