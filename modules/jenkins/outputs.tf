output "jenkins_release_name" {
  description = "Jenkins Helm release name"
  value       = helm_release.jenkins.name
}

output "jenkins_namespace" {
  description = "Jenkins namespace"
  value       = helm_release.jenkins.namespace
}