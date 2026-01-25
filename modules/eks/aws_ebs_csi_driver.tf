# TODO: EBS CSI Driver + OIDC Provider for IRSA
# This file will contain:
# - aws_iam_openid_connect_provider (OIDC for IRSA)
# - aws_iam_role (ebs_csi_irsa_role)
# - aws_iam_role_policy_attachment (AmazonEBSCSIDriverPolicy)
# - aws_eks_addon (aws-ebs-csi-driver)

# Required for Jenkins persistent storage and any other PVC in the cluster