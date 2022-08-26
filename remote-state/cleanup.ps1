remove-item -r .\.terraform.lock.hcl -ErrorAction Ignore
remove-item -r .\.terraform -ErrorAction Ignore
remove-item -r .\.pluralith -ErrorAction Ignore
remove-item -r .\terraform.tfstate* -ErrorAction Ignore