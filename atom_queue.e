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
		do
			io.put_string ("Adding atom %N")
			queue_size := queue_size + 1
		ensure
			queue_size = old queue_size + 1
		end

	current_size: INTEGER
		do
			Result := counter
		end

	check_counter (size: INTEGER): BOOLEAN
		do
			Result := counter >= size
		end

	check_queue (size: INTEGER): BOOLEAN
		do
			io.put_string ("queue size:" + queue_size.out + "%N")
			Result := queue_size >= size
		end

	consume_atoms (number_atom: INTEGER)
			--It will remove from the queue the number of atoms given.
		do
			queue_size := queue_size - number_atom
			io.put_string ("atom removed from queue %N")
		ensure
			queue_size = old queue_size - number_atom and queue_size >= 0
		end

	increase_counter (delta: INTEGER)
		do
			counter := counter + delta
		ensure
			counter = old counter + delta
		end

	decrease_counter (delta: INTEGER)
		do
			counter := counter - delta
		ensure
			counter = old counter - delta
		end

feature {NONE}

	queue_size: INTEGER

	counter: INTEGER

invariant
	queue_size >= 0

end
