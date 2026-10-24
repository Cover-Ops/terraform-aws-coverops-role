# terraform-aws-coverops-role

The IAM role CoverOps uses to read your AWS account: read-only by default, with an External ID. Generated from the same policy the CoverOps connect wizard and CloudFormation template show.

```hcl
module "coverops" {
  source      = "github.com/Cover-Ops/terraform-aws-coverops-role"
  external_id = "<the External ID from Cloud accounts → Add account>"
}
```

Then paste `module.coverops.role_arn` into CoverOps. Set `access_level = "read_write"` only if you want CoverOps to act, and then only on resources you tag `coverops:managed=true`.
