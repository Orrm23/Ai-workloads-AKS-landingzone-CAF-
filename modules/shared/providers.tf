provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
    key_vault {
      purge_soft_delete_on_destroy    = false
      recover_soft_deleted_key_vaults = true
    }
    api_management {
      purge_soft_delete_on_destroy = false
    }
    virtual_machine {
      delete_os_disk_on_deletion = true
    }
  }
}
