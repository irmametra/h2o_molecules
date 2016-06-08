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

	make
			-- Creation procedure
		do
			queue_size := 0
			counter := 0
		end

feature {HYDROGEN, OXYGEN} -- Restricted access to only atom classes

	add_atom
			-- Adds an atom to this queue
		do
			io.put_string ("Adding atom %N")
			queue_size := queue_size + 1
		ensure
			queue_size = old queue_size + 1
		end

	consume_atoms (number_atom: INTEGER)
			--It will remove from the queue the number of atoms given
			--`number_atom' the number of atoms to be consumed
		do
			queue_size := queue_size - number_atom
			io.put_string ("atom removed from queue %N")
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
			io.put_string ("queue size:" + queue_size.out + "%N")
			Result := queue_size >= size
		end

feature {NONE}

	queue_size: INTEGER -- Number of atoms in the queue
	
	counter: INTEGER -- Counter used for atom threads synchronization

invariant
	queue_size >= 0

end
