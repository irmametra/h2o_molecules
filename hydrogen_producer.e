note
	description: "Summary description for {HYDROGEN_PRODUCER}.This class produces the atoms of hydrogen"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HYDROGEN_PRODUCER

inherit

	PROCESS
	EXECUTION_ENVIRONMENT

create
	make

feature -- Initialization

	make (a_hydrogen_queue: separate ATOM_QUEUE; an_oxygen_queue: separate ATOM_QUEUE; a_barrier: separate BARRIER; a_max: INTEGER)
			--Creation Procedure
			--a_max is the maximum number of atoms of hydrogen to be produced					
		require
			a_max >= 0
			a_hydrogen_queue /= void
			an_oxygen_queue /= void
			a_barrier /= void
		do
			max := a_max
			counter := 0
			hydrogen_queue := a_hydrogen_queue
			oxygen_queue := an_oxygen_queue
			barrier := a_barrier
		end

	launch_process(a_producer: separate PROCESS)
		do
			a_producer.live
		end

feature {NONE} -- Access

	step
			-- Perform a producing hydrogen atoms tasks.
		local
			hydrogen: separate HYDROGEN
		do
			io.put_string ("Producing a hydrogen atom %N")
			create hydrogen.make (hydrogen_queue,oxygen_queue,barrier) --create the hydrogen the queue
			produce_hydrogen(hydrogen, hydrogen_queue)
			counter := counter + 1
			sleep(1_000_000_000)
		end

	over: BOOLEAN
			-- Is execution over?
		do
			Result := counter = max - 1
		end

	produce_hydrogen(a_hydrogen: separate HYDROGEN; my_hydrogen_queue: separate ATOM_QUEUE)
		do
			a_hydrogen.main
		end

feature {NONE}

	max: INTEGER
	counter: INTEGER
	hydrogen_queue: separate ATOM_QUEUE
	oxygen_queue: separate ATOM_QUEUE
	barrier: separate BARRIER

invariant
	counter < max
	hydrogen_queue /= void
	oxygen_queue  /= void
	counter >= 0
	max > 0
	barrier /= void

end
