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

    make (a_hydrogen_queue: separate ATOM_QUEUE; an_oxygen_queue: separate ATOM_QUEUE)
		--Creation Procedure
		require
			a_hydrogen_queue /= void
			an_oxygen_queue /= void
		do
			hydrogen_queue := a_hydrogen_queue
			oxygen_queue := an_oxygen_queue
		end

feature {NONE}

	prepare ()
	require
		hydrogen_queue.check_atoms(2) and oxygen_queue.check_atoms(1)

		do
			---this would unlock all locked
			hydrogen_queue.consume_atom
			oxygen_queue.consume_atom

		end


feature {NONE}

	hydrogen_queue: separate ATOM_QUEUE

	oxygen_queue: separate ATOM_QUEUE

invariant

	hydrogen_queue /= void
	oxygen_queue /= void

end
