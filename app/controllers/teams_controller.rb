class TeamsController < ApplicationController
	def generate_schedule
		Game.generate_schedules
	end

	def show_schedule
		@team = Team.find(params[:id])
		@schedule = @team.game_schedule
		# schedule is just Array of Games.
	end


	def index
		@teams = Team.all(:order => 'community')
	end

	def show
		@team = Team.find(params[:id])
		@playingfield = Playingfield.find(@team.firstfield)
		@playingfield2 = Playingfield.find(@team.secondfield)
	end

	def new
		@team = Team.new
		@weights = Weight.all
	end

	def create
		@team = Team.new(params[:team])
		@gameschedule = Gameschedule.new
		@gameschedule.save
		@team.scheduleid = @gameschedule.id		

		if @team.save
			redirect_to teams_path, :notice => "The team was added"
		else
			render "new"
		end
	end

	def edit
		@team = Team.find(params[:id])
	end

	def update
		@team = Team.find(params[:id])
		if @team.update_attributes(params[:team])
			redirect_to teams_path, :notice=> "The team has been updated"
		else
			render "edit"
		end
	end

	def destroy
		@team = Team.find(params[:id])
		@team.destroy
			redirect_to teams_path, :notice=>"The team has been deleted"
	end
 
end
