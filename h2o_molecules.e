note
	description: "H2O molecules root class"
	date: "$Date$"
	revision: "$Revision$"

class
	H2O_MOLECULES

inherit

	ARGUMENTS

create
	make

feature -- Initialization

	make
		do
		end
			-- Creation procedure.



---when we create the barrier create it as barrier(3)
feature {NONE} -- Initialization

	number_of_hydrogens: INTEGER = 20

	number_of_oxygens: INTEGER = 35

end
