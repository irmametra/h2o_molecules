note
	description: "General characteristics of a process."
	author: "Irma Metra & Danilo Figueira Mendonça"
	date: "May 2016"
	revision: "$Revision$"

deferred class
	ATOM


feature
	make_random_generator
			-- Creates a random generator using the current time as a seed
		do
			create l_time.make_now
		    l_seed := l_time.hour
		    l_seed := l_seed * 60 + l_time.minute
		    l_seed := l_seed * 60 + l_time.second
		    l_seed := l_seed * 1000 + l_time.milli_second
		    create random_number_generator.make
		    random_number_generator.set_seed (l_seed)
		end

feature

	live
			-- The behavior of this atom
		deferred
		end

	delay (milliseconds: INTEGER_64)
			-- Delay execution by `milliseconds'.
		do
			(create {EXECUTION_ENVIRONMENT}).sleep (milliseconds * 1_000_000)
		end


feature

	l_time: TIME -- current time used to generate a seed

    l_seed: INTEGER -- a seed used by the random generator

	random_number_generator: RANDOM -- used to generate random intervals for atoms
end
