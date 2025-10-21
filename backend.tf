terraform {
  backend "s3" {
    bucket         = "tuliocruz-iac-lab-tfstate"
    key            = "eu-north-1/tuliocruz-iac-lab/terraform.tfstate"
    region         = "eu-north-1"
    encrypt        = true  // Recommended for sensitive state data
    use_lockfile   = true  // Enables S3-native state locking 
  }
}