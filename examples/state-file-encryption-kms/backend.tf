terraform {
  backend "s3" {
    bucket = "okms1017" 
    key = "terraform.tfstate"
    region = "ap-northeast-2"
    encrypt = true
  }

  encryption {
    key_provider "aws_kms" "kms" {
      kms_key_id = "63483d75-ade8-4a0a-8e95-1f68d7bc69d9" 
      region = "ap-northeast-2"
      key_spec = "AES_256"
    }

    method "aes_gcm" "my_method" {
      keys = key_provider.aws_kms.kms
    }

    ## Remove this after the migration:
    method "unencrypted" "migration" {
    }

    state {
      method = method.aes_gcm.my_method

      ## Remove the fallback block after migration:
      fallback{
        method = method.unencrypted.migration
      }
      # Enable this after migration:
      enforced = false
    }
  }
}