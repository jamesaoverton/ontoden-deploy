# ontoden deploy

Here are scripts to get [ontoden](https://github.com/ontoden) tools running on your machine. So far [Ontobee](https://github.com/ontoden/ontobee) and [OntoFox](https://code.google.com/p/ontofox).

You have two installation options: a local virtual machine or your own server. Once that's running, there are some manual steps required to load more ontologies.


## Local Virtual Machine

A local virtual machine is the best option for testing. You'll need to install:

- [Ansible](http://www.ansible.com) for configuration management
- [VirtualBox](https://www.virtualbox.org) for virtual machine hosting
- [Vagrant](https://www.vagrantup.com) for VM configuration

Then you can run these commands:

    git clone https://github.com/jamesaoverton/ontoden-deploy.git
    cd ontoden-deploy
    vagrant up

It will take a while to download and install everything, but when it's done you can see your work:

- Ontobee: <http://ontobee.172.16.100.2.xip.io>
- OntoFox: <http://ontofox.172.16.100.2.xip.io>
- Virtuoso: <http://172.16.100.2:8890>

(<http://xip.io> is a "magic" DNS server that will redirect to your localhost. This is convenient when working with vhosts in Vagrant. It does not expose your virtual machine to the Internet, it just tells your browser to access the virtual machine in the right way.)

See below for additional manual steps. Other things you can do with Vagrant:

- log in to the virtual machine: `vagrant ssh`
- run the Ansible configuration again: `vagrant provision`
- stop the VM and delete all its files: `vagrant destroy`

When run from Vagrant, the Ansible scripts use the `vagrant` user and the firewall is turned off. You can access MySQL using your preferred client (such as [MySQL Workbench](http://mysqlworkbench.org)) with user "root" at IP 172.16.100.2 and port 3306.


## Server

You can use the same Ansible scripts to configure any server running 64-bit Debian 7, whether it be on Amazon Web Services, Linode, or whatever you prefer. You probably want a fresh machine, though, because the scripts might not play nice with other software you've installed.

On your local machine you only need to install Ansible, not Vagrant and VirtualBox. Then get a copy of the scripts:

    git clone https://github.com/jamesaoverton/ontoden-deploy.git
    cd ontoden-deploy

Edit the `vars/user.yml` file with your own passwords. See `var/defaults.yml` for the available options.

Edit `hosts` to contain the IP address of your server. Then run Ansible using:

    ansible-playbook -i ./hosts site.yml

It's safe to run Ansible repeatedly, when you want to update packages or you've changed the configuration. Ansible will use the `admin` user and `sudo`.

DNS is always a little tricky. I suggest creating A records with your server's IP for the `ontobee` and `ontofox` subdomains of `domain` in your `var/user.yml`.

The firewall is set to block everything except SSH and HTTP. To access Virtuoso's administration console I suggest creating an SSH tunnel to your local machine:
    
    ssh admin@your-server.org -L 8890:localhost:8890 -N

Then access Virtuoso at <http://localhost:8890>.

To access MySQL using your preferred client (such as [MySQL Workbench](http://mysqlworkbench.org)), create another tunnel:
    
    ssh admin@your-server.org -L 3306:localhost:3306 -N

Then connect as "root" to localhost on port 3306.


## Manual Steps

We haven't yet automated the process of loading ontology files into Virtuoso.

1. open Virtuoso in your browser (links in the instructions above)
2. click the Conductor link at the top left
3. log in as "dba" with your `virtuoso_dba_password` from `vars/user.yml`
4. follow [these instructions](http://virtuoso.openlinksw.com/dataspace/doc/dav/wiki/Main/VirtTipsAndTricksGuideImportOntology)

You might also want to modify the `ontobee.ontology` MySQL table.


## Known Problems

- Ontobee has an external dependency that we're currently disabling: <https://github.com/ontoden/ontobee/issues/6>
- There's no code for loading ontologies, and the tables in `roles/ontobee/files` are just reverse-engineered hacks.
- Not everything works yet. A good place to start debugging is `/var/log/apache2/ontobee_error.log`.




# License

Copyright 2014 James A. Overton, distributed under the Simplified BSD license.



