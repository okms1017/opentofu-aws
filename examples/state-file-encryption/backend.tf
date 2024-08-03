terraform {
  encryption {
    key_provider "pbkdf2" "my_passphrase" {
      ## Enter a passphrase here:
      passphrase = "ChangeIt_123abcd"
    }

    method "aes_gcm" "my_method" {
      keys = key_provider.pbkdf2.my_passphrase
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
      ## Enable this after migration:
      enforced = true
    }
  }
}