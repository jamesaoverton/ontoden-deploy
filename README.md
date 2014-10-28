# ontoden deploy

Here are scripts to get [ontoden](https://github.com/ontoden) tools (so far just [Ontobee](https://github.com/ontoden/ontobee)) running on your own machine. The main tools used are:

- [Ansible](http://www.ansible.com) for configuration management
- [Virtuoso Open Source Edition](http://virtuoso.openlinksw.com/dataspace/doc/dav/wiki/Main/) for the triplestore
- [Vagrant](https://www.vagrantup.com) for local virtual machines

I took [sovereign](https://github.com/al3x/sovereign) as a starting point for using Ansible and Vagrant.


## 1. Edit `vars/user.yml`

Customize the `vars/user.yml` file with your own passwords. See `var/defaults.yml` for the available options.


## 2. Set up a server.

The system has been tested on 64-bit Debian 7 Linux. You can host it in a local virtual machine, on Amazon Web Services, Linode, your own machine -- whatever you like -- but these scripts expect to have full control of the box.

For local testing you can quickly set up a virtual machine using Vagrant with VirtualBox:

- [install VirtualBox](https://www.virtualbox.org)
- [install Vagrant](https://docs.vagrantup.com/v2/installation/)
- run `vagrant up`
- wait for everything to download and start...
- skip to step 4
- when you're done, delete the virtual machine with `vagrant destroy`

Ansible is configured to use Debian's default `admin` user, which has `sudo` privileges. With Vagrant it will use the `vagrant` user instead.


## 3. Run Ansible

Make sure that you have [Ansible 1.6+ installed](http://docs.ansible.com/intro_installation.html#getting-ansible). Edit the `hosts` file to include the IP of your server. Then run ansible:

    ansible-playbook -i ./hosts site.yml

Ansible automates the many steps required to get ontden tools running. You can safely run Ansbile over and over again as you tweak the configuration.

If you're using Vagrant, this command will run Ansible again: `vagrant provision`.


## 4. Manual Steps

Rather than expose the Virtuoso console to the whole Internet, I suggest creating an SSH tunnel to your local machine:
    
    ssh admin@your-server.org -L 8890:localhost:8890 -N

Then open <http://localhost:8890>, log in as "dba" with your `virtuoso_dba_password`, and follow these instructions <http://virtuoso.openlinksw.com/dataspace/doc/dav/wiki/Main/VirtTipsAndTricksGuideImportOntology>. You might also want to modify the `ontobee.ontology` MySQL table.


## Known Problems

- Ontobee has an external dependency that we're currently disabling: <https://github.com/ontoden/ontobee/issues/6>
- There's no code for loading ontologies, and the tables in `roles/ontobee/files` are just reverse-engineered hacks.




