note
	description: "Summary description for {BARRIER}."
	author: "Irma Metra & Danilo Figueira Mendonça"
	date: "May 2016"
	revision: "$Revision$"

class
	BARRIER

create
	make

feature

	make
			-- Creation procedure
		do
			oxygens := 0
			hydrogens := 0
		end

feature {HYDROGEN, OXYGEN}


	has_space_for_oxygen:BOOLEAN
		do
			Result := oxygens < 1
		end

	has_space_for_hydrogen:BOOLEAN
		do
			Result := hydrogens < 2
		end

	increment_oxygen
		do
			oxygens := oxygens + 1
		ensure
			oxygens = old oxygens + 1
		end

	increment_hydrogen
		do
			hydrogens := hydrogens + 1
		ensure
			hydrogens = old hydrogens + 1
		end

	try_bond
			-- Checks if there is space for an oxygen atom in the barrier
		do
			if oxygens = 1 and hydrogens = 2 then
				io.put_string ("Molecule ready %N")
				reset_barrier
			end
		ensure
			if old oxygens = 1 and old hydrogens = 2 then oxygens = 0 and hydrogens = 0 else oxygens = old oxygens and hydrogens = old hydrogens end
		end

feature {NONE}

	reset_barrier
			-- Resets the oxygen and hydrogen counters
		require
			oxygens = 1 and hydrogens = 2
		do
			oxygens := 0
			hydrogens := 0
		ensure
			oxygens = 0 and hydrogens = 0
		end


feature {NONE}

	oxygens: INTEGER -- The number of atoms that have bonded

	hydrogens: INTEGER -- The number of atoms that have passed

invariant
	oxygens >= 0
	oxygens <= 1
	hydrogens >= 0
	hydrogens <= 2

end
