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
		local
			hydrogen_producer: separate HYDROGEN_PRODUCER
			oxygen_producer: separate OXYGEN_PRODUCER
			--collector: separate COLLECTOR
		do
			io.put_string ("Starting H2O production %N")
			create hydrogen_queue.make
			create oxygen_queue.make
			create barrier.make (3)
			create hydrogen_producer.make(hydrogen_queue, oxygen_queue, barrier, number_of_hydrogens)
			create oxygen_producer.make(hydrogen_queue, oxygen_queue, barrier, number_of_oxygens)
			--create collector.make(hydrogen_queue, oxygen_queue, barrier)
			launch_process(hydrogen_producer)
			launch_process(oxygen_producer)
			--launch_process(collector)

		end

	launch_process(a_producer: separate PROCESS)
		do
			a_producer.live
		end

---when we create the barrier create it as barrier(3)
feature {NONE} -- Initialization

	number_of_hydrogens: INTEGER = 50
	number_of_oxygens: INTEGER = 35
	hydrogen_queue: separate ATOM_QUEUE
	oxygen_queue: separate ATOM_QUEUE
	barrier: separate BARRIER

end
