note
	description: "Summary description for {ATOM_QUEUE}."
	author: "Irma Metra & Danilo Figueira Mendonça"
	date: "May 2016"
	revision: "$Revision$"

class
	ATOM_QUEUE

create
	make

feature -- Initialization

	make (an_atom_type: INTEGER)
			-- Creation procedure
		do
			queue_size := 0
			counter := 0
			atom_type := an_atom_type
		end

feature {HYDROGEN, OXYGEN} -- Restricted access to only atom classes

	add_atom
			-- Adds an atom to this queue
		do
			--done just for the purpose of logging which type of queue we are dealing with
			if (atom_type = TYPE_HYDROGEN) then
				io.put_string ("Adding atom to the hydrogen queue %N")
			else
				io.put_string ("Adding atom to the oxygen queue %N")
			end
			queue_size := queue_size + 1
		ensure
			queue_size = old queue_size + 1
		end

	consume_atoms (number_atom: INTEGER)
			--It will remove from the queue the number of atoms given
			--`number_atom' the number of atoms to be consumed
		do
			queue_size := queue_size - number_atom

			--done just for the purpose of logging which queue we are checking
			if (atom_type = TYPE_HYDROGEN) then
				io.put_string (number_atom.out + " atom(s) removed from hydrogen queue (queue size: " + queue_size.out + ")%N")
			else
				io.put_string (number_atom.out + " atom(s) removed from oxygen queue (queue size: " + queue_size.out + ")%N")
			end
		ensure
			queue_size = old queue_size - number_atom and queue_size >= 0
		end

	increase_counter (delta: INTEGER)
			-- Increments the counter, which is used for syncrhonizing threads before they bond
			--`delta' the delta by which the counter should be incremented
		do
			counter := counter + delta
		ensure
			counter = old counter + delta
		end

	decrease_counter (delta: INTEGER)
		do
			-- Decreases the counter, which is used for syncrhonizing atoms threads before they bond
			counter := counter - delta
		ensure
			counter = old counter - delta
		end

	current_size: INTEGER
			-- Returns the number of atoms currently in this queue
		do
			Result := counter
		end

	check_counter (size: INTEGER): BOOLEAN
			-- Returns a boolean indicating if counter is greater or equal the a given size
			--`size' The value counter will be compared against
		do
			Result := counter >= size
		end

	check_queue (size: INTEGER): BOOLEAN
			-- Returns a boolean indicating if number of atoms is greater or equal a given size
			--`size' The value the atoms queue size will be compared against
		do
			Result := queue_size >= size
		end

feature {NONE}

	queue_size: INTEGER -- Number of atoms in the queue

	counter: INTEGER -- Counter used for atom threads synchronization

	atom_type: INTEGER --Detects hydrogen or oxygen atom

feature

	TYPE_HYDROGEN: INTEGER = 1

	TYPE_OXYGEN: INTEGER = 2

invariant
	queue_size >= 0

end
