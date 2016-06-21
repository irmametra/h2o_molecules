note
	description: "Summary description for {HYDROGEN}."
	author: "Irma Metra & Danilo Figueira Mendonça"
	date: "May 2016"
	revision: "$Revision$"

class
	HYDROGEN

inherit
	PROCESS

create
	make

feature -- Initialization

	make (an_id: INTEGER; a_barrier: separate BARRIER)
			--Creation Procedure--`an_id' the id of the current hydrogen atom
			--`a_max' is the maximum number of atoms of hydrogen to be produced
			--`a_barrier' is shared barrier where two hydrogen atoms and one hydrogen atom must bond for a molecule to be ready
		require
			an_id >= 0
			a_barrier /= void
		do
			id := an_id
			barrier := a_barrier
			make_random_generator
		end

feature

	live
			-- The behavior of a hydrogen atom
			-- It waits a random interval from 0 - 800ms before trying to bond to avoid deterministic traces
		do
			delay ((800 * random_number_generator.real_i_th (id)).floor)
			try_bond (barrier)
		end

feature {NONE}

	increment_atom(my_barrier: separate BARRIER)
			-- Separate call to increment the nuber of hydrogen atoms in the barrier
		do
			my_barrier.increment_hydrogen
		end

	try_bond (my_barrier: separate BARRIER)
			-- try to bond the hydrogen atom in the barrier
		require
			my_barrier.has_space_for_hydrogen
		do
			io.put_string ("Hydrogen-" + id.out + " bonded %N")
			increment_atom(my_barrier)
			my_barrier.try_bond
		end

feature {NONE}

	barrier: separate BARRIER -- a reference to the barrier

	id: INTEGER -- id of this atom

invariant

	barrier /= void

	id >= 0

end
