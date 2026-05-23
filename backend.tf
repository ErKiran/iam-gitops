terraform {


  cloud {
    
    organization = "iamgitops"

    workspaces {
      name = "iam-ops"
    }
  }
}