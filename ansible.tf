resource "time_sleep" "wait_45_seconds" {
  depends_on = [aws_eip_association.eip_assoc]

  create_duration = "45s"
}

resource "ansible_playbook" "playbook" {
  depends_on = [time_sleep.wait_45_seconds]

  playbook   = "${var.ansible_playbook}"
  name       = "${aws_eip.webip.public_ip}"
  replayable = true
  groups = ["veecode"]

  vault_password_file = "${var.ansible_vault_password_file}"
  vault_files = [
    "${var.ansible_vault}"
  ]
  extra_vars = {
    HOST_NAME                    = "${var.host_name}"
    ansible_user                 = "${var.ansible_user}"
    ansible_ssh_private_key_file = "${var.ansible_ssh_private_key_file}"
    ansible_ssh_common_args      = "-o StrictHostKeyChecking=no"
  }
}
