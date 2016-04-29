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
			max := a_max
			counter := 0
		end

feature {HYDROGEN, OXYGEN}

	bond
		do
			counter := counter + 1
			if counter = 3 then
				counter := 0
				io.put_string ("Molecule ready %N")
			end

		ensure
			if old counter = 2 then
			counter = 0
			else
			counter = old counter + 1
			end
		end

	wait: BOOLEAN
		do
			Result := counter = max
		end

feature {NONE}

	max: INTEGER

	counter: INTEGER

invariant
	counter_positive: counter >= 0

end
