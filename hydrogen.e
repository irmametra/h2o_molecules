note
	description: "Summary description for {HYDROGEN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HYDROGEN

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
			--main(hydrogen_queue, oxygen_queue, barrier)
		end

feature

	main
		do
			increment_atom(hydrogen_queue)
			release(hydrogen_queue, oxygen_queue)
			wait_hydrogen(hydrogen_queue)
			barrier_bond(barrier)
			wait_in_the_barrier(barrier)
		end

feature {NONE}

	release(my_hydrogen_queue: separate ATOM_QUEUE; my_oxygen_queue: separate ATOM_QUEUE)
		do
			if (my_hydrogen_queue.check_queue (2) and my_hydrogen_queue.check_queue (1))then
				io.put_string ("GOOD TO GO %N")
				my_hydrogen_queue.consume_atoms (2)
				my_oxygen_queue.consume_atoms (1)
				my_hydrogen_queue.increase_counter (2)
				my_oxygen_queue.increase_counter (1)
			end
		end

	increment_atom(my_hydrogen_queue: separate ATOM_QUEUE)
		do
			my_hydrogen_queue.add_atom
		end

	wait_hydrogen(my_hydrogen_queue: separate ATOM_QUEUE)
		require
			my_hydrogen_queue.check_counter (1)
		do
			my_hydrogen_queue.decrease_counter (1)
			io.put_string ("Hydrogen released %N")
		end

	barrier_bond(my_barrier: separate BARRIER)
		do
			my_barrier.bond
		end

	wait_in_the_barrier(my_barrier: separate BARRIER)
		require
			my_barrier.wait
		do
			io.put_string ("Hydrogen passed barrier %N")
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
