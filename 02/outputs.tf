output "public_ips" {

  value = {

    for vm_name, vm in google_compute_instance.bankingproject2026_vm :

    vm_name => vm.network_interface[0].access_config[0].nat_ip

  }

}

output "private_ips" {

  value = {

    for vm_name, vm in google_compute_instance.bankingproject2026_vm :

    vm_name => vm.network_interface[0].network_ip

  }

}

output "vpc_name" {

  value = google_compute_network.bankingproject2026_vpc.name

}

output "subnet_name" {

  value = google_compute_subnetwork.bankingproject2026_subnet.name

}