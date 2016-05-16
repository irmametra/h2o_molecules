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

	make (an_id: INTEGER; a_hydrogen_queue: separate ATOM_QUEUE; an_oxygen_queue: separate ATOM_QUEUE; a_barrier: separate BARRIER)
			--Creation Procedure
		require
			an_id >= 0
			a_hydrogen_queue /= void
			an_oxygen_queue /= void
			a_barrier /= void
		do
			id := an_id
			hydrogen_queue := a_hydrogen_queue
			oxygen_queue := an_oxygen_queue
			barrier := a_barrier
				--main(hydrogen_queue, oxygen_queue, barrier)
		end

feature

	main
		do
			increment_atom (oxygen_queue)
			release (hydrogen_queue, oxygen_queue)
			wait_oxygen (oxygen_queue)
			barrier_bond (barrier)
			wait_in_the_barrier (barrier)
		end

feature {NONE}

	release (my_hydrogen_queue: separate ATOM_QUEUE; my_oxygen_queue: separate ATOM_QUEUE)
		do
			if (my_hydrogen_queue.check_queue (2)) then
				io.put_string ("GOOD TO GO (Oxygen) %N")
				my_hydrogen_queue.consume_atoms (2)
				my_oxygen_queue.consume_atoms (1)
				my_hydrogen_queue.increase_counter (2)
				my_oxygen_queue.increase_counter (1)
			end
		end

	increment_atom (my_oxygen_queue: separate ATOM_QUEUE)
		do
			my_oxygen_queue.add_atom
		end

	wait_oxygen (my_oxygen_queue: separate ATOM_QUEUE)
		require
			my_oxygen_queue.check_counter (1)
		do
			my_oxygen_queue.decrease_counter (1)
			io.put_string ("Oxygen-" + id.out + " released %N")
		end

	barrier_bond (my_barrier: separate BARRIER)
		do
			my_barrier.bond
		end

	wait_in_the_barrier (my_barrier: separate BARRIER)
		require
			my_barrier.wait
		do
			io.put_string ("Oxygen-" + id.out + " bonded %N")
			my_barrier.pass
		end

feature {NONE}

	hydrogen_queue: separate ATOM_QUEUE

	oxygen_queue: separate ATOM_QUEUE

	barrier: separate BARRIER

	id: INTEGER

invariant
	hydrogen_queue /= void
	oxygen_queue /= void
	barrier /= void
	id >= 0

end
