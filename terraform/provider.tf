provider "google" { 
  credentials = "${file("./creds/account.json")}"
  project     = "${var.gcp_project}"
  region      = "${var.region}"
}
