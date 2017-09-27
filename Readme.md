Terraform Dash Docs Generator
=======================

This projects essence has been taken from https://github.com/f440/terraform/tree/docset and updated to generate docs until terraform v0.9.11 and from v0.10.0 and up.

### Terraform < v0.9.0
All docs had been managed within terraform repo https://github.com/hashicorp/terraform and can be created by executing `./build_until_0.9.sh`.
This will build the `Terraform.docset`s for all available tags (without RC and beta).
Some versions can't be built because markdown to html rendering crashes - which seems to be an issue of the origin docs.
Those versions won't be included at the resulting docset collection.

### Terraform >= v0.10.0
Starting from version 0.10.0 the terraform providers had been outsourced into separate repos and the new repo https://github.com/hashicorp/terraform-website contains the main docs and the provider docs via git submodules.
There is no tagging mechanism to determine the terraform version and terraform providers are versioned separate, so the docset for terraform v0.10.0 and up can only be created for the current existing state of the repo.
The terraform version must be passed to `./build_current_from_0.10.sh <version>` move the docset into a proper directory.
