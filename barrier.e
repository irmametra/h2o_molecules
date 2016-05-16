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
			bond_counter := 0
			pass_counter := max
		end

feature {HYDROGEN, OXYGEN}

	bond
		do
			bond_counter := bond_counter + 1
			if bond_counter = max then
				io.put_string ("Molecule ready in the barrier %N")
			end
		ensure
			bond_counter = old bond_counter + 1
		end

	pass
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
		do
			Result := bond_counter = max
		end

feature {NONE}

	max: INTEGER

	bond_counter: INTEGER

	pass_counter: INTEGER

invariant
	bond_counter_positive: bond_counter >= 0

end
