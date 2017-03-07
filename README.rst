=============
Vagrant-slurm
=============

Vagrant configuration for setting up 
`Slurm Workload Manager <https://slurm.schedmd.com>`_ development environment.


Prerequisites
-------------

To be able to use this, you'll need to install
`Virtualbox <http://www.virtualbox.org/>`_ and
`Vagrant <http://www.vagrantup.com/>`_ on your system.


Setting up environment
----------------------

To setup the environment, just run:

.. code:: bash

    vagrant up


Testing
-------

SSH to the controller node:

.. code:: bash

    vagrant ssh controller

and run a new job with:

.. code:: bash

    srun /storage/local/test.sh

If it prints ``OK``, it means that command has been executed on the worker 
node and has ran docker container successfully, so everything works as 
expected.
