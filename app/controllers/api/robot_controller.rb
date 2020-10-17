# require 'services/robotics'

class Api::RobotController < ApplicationController
	before_action :robot_params

	def orders
		if (params.has_key?'commands') &&  is_request_valid?(params['commands'])
			render json: Robotics.new(params['commands']).call		
		else
			head :unprocessable_entity
		end
	end

	private

	def robot_params
		params.require(:robot).permit(:commands)
	end

	def is_request_valid?(args)
		args.flatten! if args.class == Array
		return false if args.length < 3
		
		(args[0].to_s.downcase.eql?'place') && \
			args[1].is_a?(Numeric) && \
			args[2].is_a?(Numeric) && \
			args[1] >= 0 && \
			args[2] >= 0
	end
end
