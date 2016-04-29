note
	description: "Summary description for {BARRIER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BARRIER

	---barrier will start with three, decrement and

create
	make

feature

	make (a_max: INTEGER)
		require
		a_max > 0
		do
			a_max := max
			counter := 0
		end

feature {HYDROGEN, OXYGEN}

	bond
		do
			counter := counter + 1
		ensure
			counter = old counter + 1
		end

	wait (atoms_total: INTEGER): BOOLEAN
		do
			Result := counter = atoms_total
		end


feature {NONE}

	max: INTEGER
	counter: INTEGER

invariant
	counter_positive: counter >= 0


end
