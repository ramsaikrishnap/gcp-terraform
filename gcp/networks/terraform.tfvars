project_id = "your-gcp-project-id"
region     = "us-central1"
vpc_name   = "my-vpc"

subnets = {
  "public-subnet-1" = {
    cidr_range = "10.0.1.0/24"
    region     = "us-central1"
    private    = false
  },
  "public-subnet-2" = {
    cidr_range = "10.0.2.0/24"
    region     = "us-east1"
    private    = false
  },
  "private-subnet-1" = {
    cidr_range = "10.0.3.0/24"
    region     = "us-central1"
    private    = true
  },
  "private-subnet-2" = {
    cidr_range = "10.0.4.0/24"
    region     = "us-east1"
    private    = true
  }
}