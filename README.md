# terraform-azurerm-nsg
Create an Azure Network Security group with rules.

Rules can be added, removed and edited by simply editing the 'Security Rules' list (map) parameter. See the exampel below.


## Example use
```terraform
locals {
  nsg_name            = "new_network_security_group"
  location            = "west europe"
  tags                = { "location" = local.location, "environment" = "DEV", "Terraform" = "TRUE" }
  resource_group_name = "test-nsg"
}

module "azure-nsg" {
  source = "./modules/terraform-azurerm-nsg"

  nsg_name            = local.nsg_name
  resource_group_name = local.resource_group_name
  location            = local.location
  tags                = local.tags
  security_rules      = [
       {
            name                       = "W32Time",
            priority                   = "100"
            direction                  = "Inbound"
            access                     = "Allow"
            protocol                   = "UDP"
            source_port_range          = "*"
            destination_port_range     = "123"
            source_address_prefix      = "*"
            destination_address_prefix = "*"
        },
        {
            name                       = "TLS_IN",
            priority                   = "110"
            direction                  = "Inbound"
            access                     = "Allow"
            protocol                   = "TCP"
            source_port_range          = "*"
            destination_port_range     = "443"
            source_address_prefix      = "*"
            destination_address_prefix = "*"
        },
         {
            name                       = "WEB_OUT",
            priority                   = "120"
            direction                  = "Outbound"
            access                     = "Allow"
            protocol                   = "TCP"
            source_port_range          = "*"
            destination_port_ranges    = ["80", "443"]
            source_address_prefix      = "*"
            destination_address_prefix = "*"
        }
    ]
}

```


## Arguments

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `resource_group_name` | `string` | True | The name of the resource group where the new Subnet Will be created. |
| `nsg_name` | `string` | True | The name of the Network Security Group to add the new rule to. |
| `location` | `string` | True | The Azure region in which to deploy the new Network Security group. |
| `security_rules` | any | True | A list of maps of the rules to add to the new security group (see exmaple above). |
| `tags` | `map` | false | A map of tags to apply to the new storage account and Private endpoint. EG - {Environment = "DEV", CreatedBy = "AC", Terraform = True} |