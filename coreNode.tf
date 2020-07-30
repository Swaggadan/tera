resource "vultr_server" "my_server" {
    plan_id = "202"
    region_id = "2"
    os_id = "270"
    hostname = "stakingNRG"
    label = "stakingNRG"
    tag = "stakingNRG"
    notify_activate = true
    script_id = vultr_startup_script.energi.id

    connection {
      type     = "ssh"
      user     = "root"
      password = vultr_server.my_server.default_password
      host     = vultr_server.my_server.main_ip
  }  
  
  provisioner "file" {
      source      = "keystore/"
      destination = "/root"
  }
  
  #provisioner "remote-exec" {
   #   inline = [
   #     "USRPASSWD=`pwgen 10 1`",
   #     "echo -e $USRPASSWD\n$USRPASSWD | sudo passwd nrgstaker 2>/dev/null",
   #     "echo $USRPASSWD > /home/root/ps"
   #   ]
  #}

}

resource "vultr_startup_script" "energi" {
    name = "energi"
    script = "#!/bin/sh\nsudo apt update && sudo apt upgrade -y && wget https://gist.githubusercontent.com/Swaggadan/91f6b116ba739fa8581723fc25e3b455/raw/a5cce9d5660fa1a6cb1283b0406ccf880a1f2e07/energi3.sh && chmod 777 energi3.sh && ./energi3.sh && mv /root/UTC* /home/nrgstaker/.energicore3/keystore/ && chmod 600 /home/nrgstaker/.energicore3/keystore/UTC* && chown -R nrgstaker:nrgstaker /home/nrgstaker/.energicore3/keystore/"
	
}

output "instance_ip" {
	  value = vultr_server.my_server.main_ip
	 
	  depends_on = [
	  
	  vultr_server.my_server
	  ]
  }
	
	output "instance_username" {
	  value = "root"
	  
	  depends_on = [
	  
	  vultr_server.my_server
	  ]
  }
  
	output "instance_password" {
	  value = vultr_server.my_server.default_password
	  depends_on = [
	  
	  vultr_server.my_server
	  ]
  }

