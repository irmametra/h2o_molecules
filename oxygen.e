note
	description: "Summary description for {OXYGEN}."
	author: "Irma Metra & Danilo Figueira Mendonça"
	date: "May 2016"
	revision: "$Revision$"

class
	OXYGEN

inherit
	ATOM

create
	make

feature -- Initialization

	make (an_id: INTEGER; a_barrier: separate BARRIER)
			--Creation Procedure--`an_id' the id of the current oxygen atom
			--`a_max' is the maximum number of atoms of hydrogen to be produced
			--`a_barrier' is shared barrier where two hydrogen atoms and one oxygen atom must bond for a molecule to be ready		
		require
			an_id >= 0
			a_barrier /= void
		do
			id := an_id
			barrier := a_barrier
			make_random_generator
		end

	live
		do
			-- The behavior of an oxygen atom
			-- It waits a random interval from 0 - 400ms before trying to bond to avoid deterministic traces
			delay ((400 * random_number_generator.real_i_th (id)).floor)
			bond (barrier)

		end


feature {NONE}

	increment_atom(my_barrier: separate BARRIER)
			-- Separate call to increment the number of oxygen atoms in the barrier
		do
			my_barrier.increment_oxygen
		end

	bond(my_barrier: separate BARRIER)
			-- try to bond the oxygen atom in the barrier
		require
			my_barrier.has_space_for_oxygen
		do
			io.put_string ("Oxygen-" + id.out + " bonded %N")
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
