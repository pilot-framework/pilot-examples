# Example Project

### Introduction

A "project" represents the top-level logical entity, while "applications" represent distinct entities that can be deployed individually. For more information, you can see [Waypoint's documentation](https://www.waypointproject.io/docs/waypoint-hcl).

This repository represents a 1:1 mapping of a project to a repository. Typically, you'll have one `waypoint.hcl` file at the top-level of your project, which defines the applications contained within. In this case, we have four applications we can deploy - each one has their own README with more information.

### Get Started

Be sure you've followed the install instructions for the [CLI](https://github.com/pilot-framework/pilot-cli).

#### Step 1

Fork this repository, then clone it onto your machine

#### Step 2

Option One: Manually edit the `waypoint.hcl` using the documentation linked above as a guideline.

Option Two: Run `pilot new project` in the top-level directory, then `pilot new app` and follow the instructions.

#### Step 3 (optional)

If your Pilot server is running on AWS, you'll need to configure it with GCP credentials, and vice versa. As long as you have `gcloud` or `awscli` installed and configured, you can re-run `pilot init` to set up our necessary metadata directory (if either tool was just installed) and then run `pilot configure --<provider>` to configure the server with an IAM user and role.

#### Step 4

Build, deploy, and release an example! It's as simple as running `pilot up <project>/<app>`.
