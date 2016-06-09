note
	description: "Summary description for {OXYGEN}."
	author: "Irma Metra & Danilo Figueira Mendonça"
	date: "May 2016"
	revision: "$Revision$"

class
	OXYGEN

create
	make

feature -- Initialization

	make (an_id: INTEGER; a_hydrogen_queue: separate ATOM_QUEUE; an_oxygen_queue: separate ATOM_QUEUE; a_barrier: separate BARRIER)
			--Creation Procedure--`an_id' the id of the current oxygen atom
			--`a_max' is the maximum number of atoms of hydrogen to be produced
			--`a_hydrogen_queue' is the shared queue storing hydrogen atoms
			--`an_oxygen_queue' is the shared queue storing oxigen atoms
			--`a_barrier' is shared barrier where two hydrogen atoms and one oxygen atom must bond for a molecule to be ready
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
		end

feature

	main
		do
			increment_atom (oxygen_queue)
			check_molecule (hydrogen_queue, oxygen_queue)
			atom_wait (oxygen_queue)
			barrier_bond (barrier)
			barrier_wait (barrier)
		end

feature {NONE}

	increment_atom (my_oxygen_queue: separate ATOM_QUEUE)
			-- increments the number of hydrogen atoms
		do
			my_oxygen_queue.add_atom
		end

	check_molecule (my_hydrogen_queue: separate ATOM_QUEUE; my_oxygen_queue: separate ATOM_QUEUE)
			-- Signalize that a molecule is ready if two hydrogen atoms are available
		do
			if (my_hydrogen_queue.check_queue (2)) then
				io.put_string ("Oxygen Check: Atoms set complete for a molecule %N")
				my_hydrogen_queue.consume_atoms (2)
				my_oxygen_queue.consume_atoms (1)
				my_hydrogen_queue.increase_counter (2)
				my_oxygen_queue.increase_counter (1)
			end
		end

	atom_wait (my_oxygen_queue: separate ATOM_QUEUE)
			-- waits for the molecule to be ready
		require
			my_oxygen_queue.check_counter (1)
		do
			my_oxygen_queue.decrease_counter (1)
		end

	barrier_bond (my_barrier: separate BARRIER)
			-- bonds the atom in the barrier
		do
			io.put_string ("Oxygen-" + id.out + " bonded %N")
			my_barrier.bond
		end

	barrier_wait (my_barrier: separate BARRIER)
			-- waits in the barrier until all molecule atoms have bonded
		require
			my_barrier.wait
		do
			io.put_string ("Oxygen-" + id.out + " passed %N")
			my_barrier.pass
		end

feature {NONE}

	hydrogen_queue: separate ATOM_QUEUE -- a reference to the hydrogen atoms queue

	oxygen_queue: separate ATOM_QUEUE -- a reference to the oxygen atoms queue

	barrier: separate BARRIER -- a reference to the barrier

	id: INTEGER -- id of this atom

invariant
	hydrogen_queue /= void
	oxygen_queue /= void
	barrier /= void
	id >= 0

end
