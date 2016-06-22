note
	description: "H2O molecules prduction root class"
	author: "Irma Metra & Danilo Figueira Mendonça"
	date: "May 2016"
	revision: "$Revision$"

class
	H2O_MOLECULES

inherit

	ARGUMENTS

create
	make

feature -- Initialization

	make
			-- Creation procedure
		local
			a_hydrogen: separate HYDROGEN
			an_oxygen: separate OXYGEN
			i: INTEGER
		do
			io.put_string ("----Starting H2O production----%N")

			create barrier.make
			io.put_string ("Launching Hydrogen producer %N")
			io.put_string ("Launching Oxygen producer %N")

			from -- make all oxygen and hydrogen and launch them to eat
				i := 1
			until
				i > number_of_molecules
			loop
				create a_hydrogen.make (i, barrier)
				launch_process (a_hydrogen)
				create a_hydrogen.make (i + 1, barrier)
				launch_process (a_hydrogen)
				create an_oxygen.make ((i/2).ceiling, barrier)
				launch_process (an_oxygen)
				i := i + 2
			end

		end

	launch_process (a_process: separate ATOM)
			-- Launches a separated {PROCESS} object by calling its live method
			-- `a_process' the {PROCESS} object to be launched
		do
			a_process.live
		end

feature {NONE} -- class variables


	number_of_molecules: INTEGER = 20 -- the number of molecules to be produced

	barrier: separate BARRIER -- the barrier used for bonding

end
