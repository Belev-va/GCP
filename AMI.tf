#create org policy
/*
resource "google_project_organization_policy" "howlight_policy" {
  project = "howlight"
  constraint = "iam.disabledAuditLoggingExemption"

  boolean_policy {
    enforced = true
  }
}
#create a service account
resource "google_service_account" "devops-sa" {
  account_id = "devops-sa"
  display_name = "devops service account"
}
*/