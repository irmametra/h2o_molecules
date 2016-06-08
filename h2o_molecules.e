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
			hydrogen_producer: separate HYDROGEN_PRODUCER
			oxygen_producer: separate OXYGEN_PRODUCER
		do
			io.put_string ("----Starting H2O production----%N")
			create hydrogen_queue.make
			create oxygen_queue.make
			create barrier.make (3)
			create hydrogen_producer.make (hydrogen_queue, oxygen_queue, barrier, number_of_hydrogens)
			create oxygen_producer.make (hydrogen_queue, oxygen_queue, barrier, number_of_oxygens)
			io.put_string ("Launching Hydrogen producer %N")
			launch_process (hydrogen_producer)
			io.put_string ("Launching Oxygen producer %N")
			launch_process (oxygen_producer)
		end

	launch_process (a_producer: separate PROCESS)
			-- Launches a separated {PROCESS} object by calling its live method
			-- `a_producer' the {PROCESS} object to be launched
		do
			a_producer.live
		end

feature {NONE} -- class variables

	number_of_hydrogens: INTEGER = 20 -- max number of hydrogens atoms to be created

	number_of_oxygens: INTEGER = 10 -- max number of oxygen atoms to be created

	hydrogen_queue: separate ATOM_QUEUE -- the hydrogen atom queue

	oxygen_queue: separate ATOM_QUEUE -- the oxygen atom queue

	barrier: separate BARRIER -- the barrier used for bonding

end
