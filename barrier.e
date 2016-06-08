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

	make (a_max: INTEGER)
			-- Creation procedure
			--`a_max' the number of atoms before the barrier releases a molecule
		require
			a_max > 0
		do
			max := a_max
			bond_counter := 0
			pass_counter := max
		end

feature {HYDROGEN, OXYGEN}

	bond
			-- Increases the bonds counter in the barrier.
		do
			bond_counter := bond_counter + 1
			if bond_counter = max then
				io.put_string ("Molecule ready in the barrier %N")
			end
		ensure
			bond_counter = old bond_counter + 1
		end

	pass
			-- Decreases the number of atoms that passed the barrier. If zero, resets the barrier.
		do
			pass_counter := pass_counter - 1
			if pass_counter = 0 then
				pass_counter := max
				bond_counter := 0
				io.put_string ("Molecule passed the barrier %N")
			end
		ensure
			if old pass_counter = 1 then pass_counter = max and bond_counter = 0 else pass_counter = old pass_counter - 1 end
		end

	wait: BOOLEAN
			-- Check if the number of atom bonds reached max
		do
			Result := bond_counter = max
		end

feature {NONE}

	max: INTEGER -- The max number of bonds before passing the barrier

	bond_counter: INTEGER -- The number of atoms that have bonded

	pass_counter: INTEGER -- The number of atoms that have passed

invariant
	bond_counter >= 0
	bond_counter <= max
	pass_counter >= 0
	pass_counter <= max

end
