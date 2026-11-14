# Changelog

Semantic versions. Every release lists its sandbox test result.

## 1.3.0 (2026-11-12)
- Read-only policy adds `logs:DescribeLogGroups`: CoverOps finds CloudWatch log groups set to never expire.
- Read-only policy adds `eks:ListNodegroups` and `eks:ListFargateProfiles`: CoverOps finds EKS clusters with nothing to run pods on.
- Sandbox test: **not run yet**.

## 1.2.0 (2026-11-12)
- Read-only policy adds `ec2:DescribeSpotPriceHistory`: without it CoverOps priced spot instances at the on-demand rate, overstating their cost.
- Read/write policy adds `ec2:CreateVolume` and `ec2:CreateTags`, only for volumes created with the tag `coverops:managed=true`: undoing a volume delete was refused before.
- Same policies as the CoverOps connect wizard, checked by a test that every call CoverOps makes is in them.
- Sandbox test: **passed 2026-11-12** (AWS ap-south-1: apply, re-plan with no changes, destroy, nothing left).

## 1.1.0 (2026-11-11)
- Follows the public module's numbering: v1.0.0 was the first public tag, so this kit release is v1.1.0.
- New inputs `role_path` and `permissions_boundary`, for accounts that file vendor roles under a path or require a boundary on new roles.
- Mandatory tags, the pinned provider range (`versions.tf`) and `examples/basic` join the public module.
- Sandbox test: **not run yet**.

## 0.1.0 (2026-11-10)
- First release as a Marketplace kit: the CoverOps access role with an External ID, read-only by default, read-write only on resources tagged `coverops:managed=true`. Same policies as the CoverOps connect wizard.
- Mandatory tags on the role: Project, Environment, Owner, CostCentre, ManagedBy, Kit.
- Sandbox test: **not run yet**.
