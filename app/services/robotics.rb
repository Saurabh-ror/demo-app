class Robotics
	

	def initialize(args)
		@@x = args[1]
		@@y = args[2]
		@request = args
		@@direction = ''
	end

	def call
		executor
	end

	private 

	def executor
		@request.shift(3)
		@request.each do |k|
			break if k.downcase.eql? 'report'
			pointer k
		end
		{ location: [@@x, @@y, @@direction.capitalize] }
	end

	def pointer(x)
		k = x.downcase
		if %w[north south east west].include?(k)
			@@direction = k
		elsif k.eql?'move'
			@@y += 1 if %w(north south).include? @@direction
			@@x += 1 if %w(east west).include? @@direction
		elsif (%w[left right].include?(k)) && @@direction
			@@direction = directions[@@direction.to_sym][k.to_sym]
		end
	end

	def directions
		{
			north: { left: 'west', right: 'east' },
			south: { left: 'east', right: 'west' },
			east: { left: 'north', right: 'south' },
			west: { left: 'south', right: 'north' }
		}
	end
end
