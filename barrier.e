note
	description: "Summary description for {BARRIER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BARRIER

---barrier will start with three, decrement and

feature{HYDROGEN,OXYGEN}

pass
	require
		hydrogen.check_atoms(2) and oxygen.check_atoms(1)

		do
			---this would unlock all locked
			hydrogen_queue.consume_atom
			oxygen_queue.consume_atom

		end
end
