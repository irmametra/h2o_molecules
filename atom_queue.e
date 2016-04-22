note
	description: "Summary description for {ATOM_QUEUE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ATOM_QUEUE

	--will be accessed by both hydrogen and oxygen

feature

	check_atoms (size: INTEGER): BOOLEAN
		require
			number_atoms >= size
		do
			Result := number_atoms >= size
		end

	consume_atom
		require
			number_atoms > 0
		do
			number_atoms := number_atoms - 1
		ensure
			number_atoms = old number_atoms - 1
		end

--TO BE CHECKED
feature {HYDROGEN_PRODUCER,OXYGEN_PRODUCER}
		add_atom
		do
			number_atoms := number_atoms + 1
		ensure
			number_atoms = old number_atoms + 1
		end


feature {NONE} -- Implementation

	number_atoms: INTEGER

end
