note
	description: "Summary description for {OXYGEN_PRODUCER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OXYGEN_PRODUCER

inherit
	PROCESS

create
	make

feature -- Initialization

	make
		do
		end

feature {NONE} -- Access

	step
			-- Perform a producing oxygen atoms tasks.
		do
		end

	over: BOOLEAN
			-- Is execution over?
		do
		end

end
