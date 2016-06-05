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
		do
			a_producer.live
		end

feature {NONE} -- class variables

	number_of_hydrogens: INTEGER = 20

	number_of_oxygens: INTEGER = 10

	hydrogen_queue: separate ATOM_QUEUE

	oxygen_queue: separate ATOM_QUEUE

	barrier: separate BARRIER

end
