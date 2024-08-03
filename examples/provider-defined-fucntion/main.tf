terraform {
  required_providers {
    corefunc = {
      source = "northwood-labs/corefunc"
      version = "1.4.0"
    }
  }
}

provider "corefunc" {
}

output "test_1" {
  value = provider::corefunc::str_snake("Hello world!")
  # Prints: hello_world
}
output "test_2" {
  value = provider::corefunc::str_camel("Hello world!")
  # Prints: hello_world
}