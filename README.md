# enu.contracts

## Version : 1.0.0

The design of the Enumivo blockchain calls for a number of smart contracts that are run at a privileged permission level in order to support functions such as block producer registration and voting, token staking for CPU and network bandwidth, RAM purchasing, multi-sig, etc.  These smart contracts are referred to as the system, token, msig and sudo contracts.

This repository contains examples of these priviledged contracts that are useful when depoying, managing, and/or using an Enumivo blockchain.  They are provided for reference purposes:

   * [enu.system](https://github.com/enumivo/enu.contracts/tree/master/enu.system)

   * [enu.msig](https://github.com/enumivo/enu.contracts/tree/master/enu.msig)
   * [enu.sudo](https://github.com/enumivo/enu.contracts/tree/master/enu.sudo)
   
The following unpriviledged contract(s) are also part of the system. 
   * [enu.token](https://github.com/enumivo/enu.contracts/tree/master/enu.token)

Dependencies:
* [enumivo v1.0.8](https://github.com/enumivo/enumivo/tree/v1.0.8)

To build the contracts and the unit tests:
* First, ensure that your __enumivo__ is compiled to the core symbol for the Enumivo blockchain that intend to deploy to.
* Second, make sure that you have ```sudo make install```ed __enumivo__.
* Then just run the ```build.sh``` in the top directory to build all the contracts and the unit tests for these contracts. If you want to skip building the unit tests, the option ```notests``` can be given to ```build.sh```.
* Or, you can run the ```build.sh``` in a given contract folder to only build that contract.

After build:
* The unit tests executable is placed in the top directory and is named __unit_test__.
* The contracts are built into a _bin/\<contract name\>_ folder in their respective directories.
* Finally, simply use __enucli__ to _set contract_ by pointing to the previously mentioned directory.
