note
	description: "Summary description for {HYDROGEN_PRODUCER}.This class produces the atoms of hydrogen"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HYDROGEN_PRODUCER

inherit

	PROCESS

create
	make

feature -- Initialization

	make (a_hydrogen_queue: separate ATOM_QUEUE; an_oxygen_queue: separate ATOM_QUEUE; a_max: INTEGER)
			--Creation Procedure
			--a_max is the maximum number of atoms of hydrogen to be produced
		require
			a_max >= 0
			a_hydrogen_queue /= void
			an_oxygen_queue /= void
		do
			max := a_max
			counter := 0
			hydrogen_queue := a_hydrogen_queue
			oxygen_queue := an_oxygen_queue
		end

feature {NONE} -- Access

	step
			-- Perform a producing hydrogen atoms tasks.
		local
			hydrogen: HYDROGEN
		do
			create hydrogen.make (hydrogen_queue) --create the hydrogen the queue
			hydrogen_queue.add_atom
			counter := counter + 1
		end

	over: BOOLEAN
			-- Is execution over?
		do
			Result := counter = max - 1
		end

feature {NONE}

	max: INTEGER

	counter: INTEGER

	hydrogen_queue: separate ATOM_QUEUE

	oxygen_queue: separate ATOM_QUEUE

invariant
	counter < max
	hydrogen_queue /= void
	oxygen_queue  /= void
	count > 0
	max > 0

end
