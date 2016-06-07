note
	description: "A class that represents a process that produces n < MAX hydrogen atoms as separated objects"
	author: "Irma Metra & Danilo Figueira Mendonça"
	date: "May 2016"
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
			--`a_max' is the maximum number of atoms of hydrogen to be produced
			--`a_hydrogen_queue' is the shared queue storing hydrogen atoms
			--`an_oxygen_queue' is the shared queue storing oxigen atoms
			--`a_barrier' is shared barrier where two hydrogen atoms and one oxygen atom must bond for a molecule to be ready
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
			create random_number_generator.make
		end

feature {NONE} -- Access

	step
			-- Produces a hydrogen atom and sleeps for 0 to 1 seconds
		local
			hydrogen: separate HYDROGEN
		do
			counter := counter + 1
			io.put_string ("Producing atom HYDROGEN ID (" + counter.out + ") %N")
			create hydrogen.make (counter, hydrogen_queue, oxygen_queue, barrier) --create the hydrogen the queue
			produce_hydrogen (hydrogen, hydrogen_queue)
			sleep ((1_000_000_000 * random_number_generator.real_i_th (counter)).floor)
		end

	over: BOOLEAN
			-- Has the MAX number of atoms been produced?
		do
			Result := counter = max
		end

	produce_hydrogen (a_hydrogen: separate HYDROGEN; my_hydrogen_queue: separate ATOM_QUEUE)
			-- Separated call triggering hydrogen behavior
		do
			a_hydrogen.main
		end

feature {NONE}

	max: INTEGER

	counter: INTEGER

	hydrogen_queue: separate ATOM_QUEUE

	oxygen_queue: separate ATOM_QUEUE

	barrier: separate BARRIER

	random_number_generator: RANDOM

invariant
	counter <= max
	hydrogen_queue /= void
	oxygen_queue /= void
	counter >= 0
	max > 0
	barrier /= void

end
