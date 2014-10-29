# ontoden deploy

Here are scripts to get [ontoden](https://github.com/ontoden) tools (so far just [Ontobee](https://github.com/ontoden/ontobee)) running on your own machine.

You have two installation options: a local virtual machine or your own server. Once that's running, there are some manual steps required to load ontologies.


## Local Virtual Machine

A local virtual machine is the best option for testing. You'll need to install:

- [Ansible](http://www.ansible.com) for configuration management
- [VirtualBox](https://www.virtualbox.org) for virtual machine hosting
- [Vagrant](https://www.vagrantup.com) for VM configuration

Then you can run these commands:

    git clone https://github.com/jamesaoverton/ontoden-deploy.git
    cd ontoden-deploy
    vagrant up

It will take a while to download and install everything, but when it's done you can see your work at <http://172.16.100.2>. Virtuoso is available at <http://172.16.100.2:8890>. See below for additional manual steps.

Other things you can do with Vagrant:

- log in to the virtual machine: `vagrant ssh`
- run the Ansible configuration again: `vagrant provision`
- stop the VM and delete all its files: `vagrant destroy`

When run from Vagrant, the Ansible scripts use the `vagrant` user.


## Server

You can use the same Ansible scripts to configure any server running 64-bit Debian 7, whether it be on Amazon Web Services, Linode, or whatever you prefer. You probably want a fresh machine, though, because the scripts might not play nice with other software you've installed.

On your local machine you only need to install Ansible, not Vagrant and VirtualBox. Then get a copy of the scripts:

    git clone https://github.com/jamesaoverton/ontoden-deploy.git
    cd ontoden-deploy

Edit the `vars/user.yml` file with your own passwords. See `var/defaults.yml` for the available options.

Edit `hosts` to contain the IP address of your server. Then run Ansible using:

    ansible-playbook -i ./hosts site.yml

It's safe to run Ansible repeatedly, when you want to update packages or you've changed the configuration. Ansible will use the `admin` user and `sudo`.

The firewall is set to block Virtuoso's administration console in this configuration. To access it I suggest creating an SSH tunnel to your local machine:
    
    ssh admin@your-server.org -L 8890:localhost:8890 -N

Then access Virtuoso at <http://localhost:8890>.


## Manual Steps

We haven't yet automated the process of loading ontology files into Virtuoso.

1. open the Virutoso in your browser
2. click the Conductor link at the top left
3. log in as "dba" with your `virtuoso_dba_password` from `vars/user.yml`
4. follow [these instructions](http://virtuoso.openlinksw.com/dataspace/doc/dav/wiki/Main/VirtTipsAndTricksGuideImportOntology)

You might also want to modify the `ontobee.ontology` MySQL table either directly, or by editing `roles/ontobee/files/ontobee.sql` and running Ansible again.


## Known Problems

- Ontobee has an external dependency that we're currently disabling: <https://github.com/ontoden/ontobee/issues/6>
- There's no code for loading ontologies, and the tables in `roles/ontobee/files` are just reverse-engineered hacks.


# License

Copyright 2014 James A. Overton, distributed under the Simplified BSD license.



