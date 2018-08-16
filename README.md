This project contains the source files and IP blocks for a number of click-based asynchronous components, as well as three example circuits built from them (2 Fibonacci implementations and 1 GCD implementation). The source files can be found and imported from the /src directory. The circuits have been built with both source files and IP blocks as examples. The IP blocks are located in the /blocks directory and the import process is described below. The block designs for the example circuits can be imported from src/Block_designs/bd.

---------------------------------------------
-	IMPORTING THE IP BLOCKS (VIVADO)
---------------------------------------------
1. Create new project
2. Create a new interface definition (Tools -> Create interface definition) with the name "async_2ph_ch". Add two new port with the following parameteres:
	### PORT 1: ###

	 - Display Name: 		req 
	 - Default value:		0
	 - Width:				1
	 - Master-Direction:	out
	 - Slave-Direction:		in

	### PORT 2: ###
	
	 - Display Name: 		ack 
	 - Default value:		0
	 - Width:				1
	 - Master-Direction:	in
	 - Slave-Direction:		out	
and save the interface. This will create the interface used by all components. For the changes to take effect restart vivado. 
3. To import the IP blocks, go to Tools -> Settings -> IP -> Repository and add the path to /blocks to the list of repositories. 
4. At this point you should be able to build block designs with the IP INTEGRATOR tool. To find the components, look-up the library click-elements.