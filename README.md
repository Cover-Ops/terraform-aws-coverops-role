# CoverOps access role

A CoverOps Marketplace kit. The IAM role the CoverOps Platform uses to read your AWS account and find savings: read-only by default, protected by an External ID. It holds the same policy the CoverOps connect wizard and CloudFormation template show. Terraform ≥ 1.6 or OpenTofu ≥ 1.6, AWS provider 6.x. Apache 2.0.

> Status: **v1.2.0, tested on 2026-11-12**: applied, re-planned with no changes and destroyed on a sandbox AWS account (ap-south-1), nothing left behind. Run `terraform plan` before you apply it to your account.

## What it creates

| Resource | Why | Cost |
|---|---|---|
| IAM role `CoverOpsAccess`, assumable only by CoverOps and only with your External ID, 1-hour sessions | CoverOps signs in without keys you'd have to hand over | Free |
| Inline policy: read-only (default) | Lets CoverOps list resources, read metrics and read Cost Explorer, nothing more | Free |
| Inline policy: read-write (only if you choose it) | Adds stop/start, snapshot, delete-volume and resize, but **only** on resources you tag `coverops:managed=true` | Free |

**Estimated monthly cost: ₹0** (estimate). Cost Explorer API requests CoverOps makes are billed to your account by AWS at $0.01 (about ₹1) each.

## What CoverOps can read
EC2 (instances, volumes, snapshots, addresses, images, NAT gateways, reservations), your AWS Organization and its account list, RDS instances and clusters, S3 bucket names, location, tags and lifecycle rules (never object contents), load balancers, Lambda function settings, CloudWatch metrics, Cost Explorer costs, forecasts and recommendations, Savings Plans, EKS clusters, Auto Scaling groups, and resource tags. The full list is in [`policies/read_only.json`](policies/read_only.json).

## Mandatory tags
The role carries `Project` (default `coverops`), `Environment`, `Owner`, `CostCentre`, `ManagedBy` and `Kit`.

## Use

```hcl
module "coverops" {
  source = "github.com/Cover-Ops/terraform-aws-coverops-role?ref=v1.2.0"

  external_id = "<the External ID from Cloud accounts → Add account>"
  environment = "production"
  owner       = "platform@acme.example"
}
```

Then paste `module.coverops.role_arn` into CoverOps. Full example: [`examples/basic`](examples/basic).

## Inputs

| Name | Description | Default |
|---|---|---|
| `external_id` | The External ID CoverOps shows when you add the account | required |
| `environment` | `production`, `staging` or `development` | required |
| `owner` | Team or email that answers for this account | required |
| `access_level` | `read_only`, or `read_write` for actions on resources tagged `coverops:managed=true` | `read_only` |
| `trusted_principal` | The CoverOps identity that assumes the role | CoverOps' control plane |
| `role_name` | Name of the role | `CoverOpsAccess` |
| `project` | Value of the Project tag | `coverops` |
| `cost_centre` | Budget line for the CostCentre tag | `engineering` |
| `extra_tags` | More tags on the role | `{}` |

## Outputs
`role_arn`: paste it into CoverOps.

## Good to know
- Apply it once per AWS account you connect. IAM is global, so the region doesn't matter.
- Without the External ID, anyone who learned the role's ARN could ask CoverOps to use it. Keep the one CoverOps gives you; don't reuse it across organisations.
- Choose `read_write` only if you want CoverOps to act for you, and tag only the resources it may touch.
- Remove access any time: `terraform destroy`, or delete the role in IAM.

## Support
Open an issue on GitHub, or write to CoverOps support from the platform.
