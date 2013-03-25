class GameschedulesController < ApplicationController

	def index
		@gameschedules = Gameschedule.all
	end

	def show
		@gameschedule = Gameschedule.find(params[:id])
	end

	# This section is used to generate a new season schedule (randomly)
	def new
		@gameschedules = Gameschedule.all
		@teams = Team.all

		#Loop for each week and select the 7 weeks of games
		# Our example code only supports 8 teams
		(1..7).each do |i|
			# Loop for half the number of teams, as there are that many games
			# For example, an 8 team schedule requires 4 games
			(1..(Team.count/2)).each do |j| 
				gameScheduled = false
				while gameScheduled = false
					#Create a new game
					@game = Game.new
					#Randomly choose hometeam, until we find one that is not already playing this week
					@tempTeam= Team.all.sample

					
					@tempSchedule = Gameschedule.find(@tempTeam.scheduleid)
					if @tempSchedule

					end
					

					(1..(Team.count)).each do |k|
						if(k)
					end
					if()





					id = 				@game.visitorteamId = Gameschedule.all.sample
					if @game.hometeamId

					#Fetch the schedule for that team
					@gameschedule = Gameschedule(tempTeam1.scheduleid)
					#
				end
			end
		end

	end

	def create
		@teams = Team.all
	end

	def edit

	end

	def update
	end

	def destroy
		@gameschedule = Gameschedule.find(params[:id])
		@gameschedule.destroy
			redirect_to gameschedules_path, :notice=>"The schedule has been deleted"

	end
end
