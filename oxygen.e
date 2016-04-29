note
	description: "Summary description for {OXYGEN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OXYGEN

create
	make

feature -- Initialization

	make (a_hydrogen_queue: separate ATOM_QUEUE; an_oxygen_queue: separate ATOM_QUEUE; a_barrier: separate BARRIER)
			--Creation Procedure
		require
			a_hydrogen_queue /= void
			an_oxygen_queue /= void
			a_barrier /= void
		do
			hydrogen_queue := a_hydrogen_queue
			oxygen_queue := an_oxygen_queue
			barrier := a_barrier
		end

feature {NONE}

	main
		do
			oxygen_queue.add_atom
			if hydrogen_queue.check_queue (2) then
				hydrogen_queue.consume_atoms (2)
				oxygen_queue.consume_atoms (1)
				hydrogen_queue.increase_counter (2)
				oxygen_queue.increase_counter (1)
			end
			wait_oxygen
			barrier.bond
			wait_in_the_barrier
		end

feature {NONE}

	wait_oxygen
		require
			oxygen_queue.check_counter (1)
		do
			oxygen_queue.decrease_counter (1)
			io.put_string ("Oxygen released %N")
		end

	wait_in_the_barrier
		require
			barrier.wait
		do
			io.put_string ("Oxygen passed barrier %N")
		end

feature {NONE}

	hydrogen_queue: separate ATOM_QUEUE

	oxygen_queue: separate ATOM_QUEUE

	barrier: separate BARRIER

invariant
	hydrogen_queue /= void
	oxygen_queue /= void
	barrier /= void

end
