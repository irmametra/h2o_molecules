note
	description: "Summary description for {ATOM_QUEUE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ATOM_QUEUE

	--will be accessed by both hydrogen and oxygen

create
	make

feature -- Initialization

	make
			-- Creation procedure.
		do
			queue_size := 0
			counter := 0
		end

feature{HYDROGEN, OXYGEN}
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
			io.put_real (counter)
			io.put_string ("c%N")
			Result := counter >= size
		end

	check_queue (size: INTEGER): BOOLEAN
		do
			io.put_real (counter)
			io.put_string ("q%N")
			Result := queue_size >= size
		end

		---define what has to access what

	consume_atoms (number_atom: INTEGER)
			--It will remove from the queue the number of atoms given.

		do
			queue_size := queue_size - number_atom
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
			counter := counter + delta
			io.put_real (counter)
			io.put_string ("c%N")
		ensure
			counter = old counter + delta
		end

feature {NONE} -- Implementation

		--hydroQueue.signal(2)

	queue_size: INTEGER
			--COUNTER is used as a semaphore for us

	counter: INTEGER

invariant
	queue_size >= 0

end
