class Game < ActiveRecord::Base
  attr_accessible :gamedate, :gametime, :hometeamId, :playingfield, :visitorteamId

  def self.generate_candidate_season(leagueTeamIds)
  	#big loop
 	candidateSeason = Array.new

   	candidateWeek = Array.new

  	#Assemble an array of the ids of all the teams in the league
  	arrayLeagueTeamIds = Array.new
  	arrayLeagueTeamIds = leagueTeamIds

  	#Weeks, games per week and total number games in season
  	weeks = 9
  	numberGamesEachWeek = arrayLeagueTeamIds.length/2
  	totalNumberGames = weeks * numberGamesEachWeek;

  	# This method uses random pairings in order to create schedules
  	# Schedules are randomly made week by week, and then criteria are evaluated
  	# to make sure the schedule is valid
  	# Occasionally, the algorithm will paint itself into a corner, in which case
  	# the entire season needs to be thrown out and started over
  	# Example:  9 week season with 10 teams (1..10).  
  	# Each team should play each other once
  	# There are (valid) scenarios where at week #8 and week #9 Teams 1,2,3 still need to play each other.
  	# Team 1 could play team 2, but then team 3 does not have an opponent without playing someone they have already played
 
 	#Loop until the algorithm succeeds without a scheduling timeout
 	schedulingWentOk=false
 	while schedulingWentOk==false

		candidateSeason = candidateSeason.clear
 		#Set to true, this value will later be set to false if it failed and needs to be run again.
 		schedulingWentOk=true

  		numberPasses=0;

	  	#Generate the entire season (weeks * numberGamesPerWeek) randomly (we will check criteria later and iterate until correct)
	  	(0..weeks-1).each do |week|

	  		# Loop until we get a week of games that meets our criteria
	  		weekScheduled=false
	  		while weekScheduled==false

				#count how many times we have attempted to schedule this week
				numberPasses = numberPasses + 1

				#Set to true, and later it will be set to false if a test fails
				weekScheduled=true

				#Randomly Create a candidate week/lineup by shuffling all the IDs
				#This approach ensures that teams don't play themselves, or play 2 games in a week
				candidateWeek = arrayLeagueTeamIds.shuffle

				#Check if the any of the games in the candidate week have already happened
				#Games will be in the even (home) + odd (away) team positions within the array

				#Loop for each game in the candidate week
				(0..candidateWeek.length-1).step(2) do |weeklyGames|
					candidateHomeTeam = candidateWeek[weeklyGames]
					candidateAwayTeam = candidateWeek[weeklyGames+1]

					#Loop through all the games of previous weeks
					(0..candidateSeason.length-1).step(2) do |i|
						comparisonHomeTeam = candidateSeason[i]
						comparisonAwayTeam = candidateSeason[i+1]

						#Make sure the home/away teams haven't already played as home/away teams
						if(candidateHomeTeam==comparisonHomeTeam)
							if(candidateAwayTeam==comparisonAwayTeam)
								weekScheduled=false
							end
						end

						#Make sure the home/away teams haven't already played as away/home teams
						if(candidateHomeTeam==comparisonAwayTeam)
							if(candidateAwayTeam==comparisonHomeTeam)
								weekScheduled=false
							end
						end
					end
				end

				# Detect if we have painted into a corner
				# If the numberPasses is greater than an arbitrary threshold (5000), then declare a stalemate/timeout
				# for this season scheduling.  Force the weekScheduled loop to exit by setting weekScheduled=true
				# However, the entire loop will be run again because 'schedulingWentOk is set to false'
				if numberPasses > 5000
					printf("Failed to schedule season (painted into corner), trying again\n");
					weekScheduled=true
					schedulingWentOk=false
				end
			end  #end of while loop

			# Record the new games into the Candidate Season
			(0..candidateWeek.length-1).each do |i|
				candidateSeason << candidateWeek[i]
			end
		end #end of weeks loop
	end	#end of scheduling timeout loop  	

  	#return the candidateSeason
  	candidateSeason
end

def self.home_games_are_scheduleable(leagueTeamIds, candidateSeason)
	numberOfTimeslots = 3
	numberOfWeeks = 9

	# Make an array of all playing fields, timeslots, and weeks
	Playingfield.count
	arraySize = Playingfield.count * numberOfTimeslots * numberOfWeeks
	fieldUsageArray = Array.new(arraySize, 0)


  	#Loop through all the home teams
	(0..candidateSeason.length-1).step(2) do |i|
		homeTeamId = candidateSeason[i]
		#find this hometeam index in sorted team array, and use that to increment the element of the homegames count array
		(0..arrayLeagueTeamIds.length-1).each do |j|
			if homeTeamId==arrayLeagueTeamIds[j]
				homeGamesCountArray[j] = homeGamesCountArray[j] + 1
			end
		end
	end

	nResult = true
	nResult
end

def self.meets_minimum_home_games(leagueTeamIds, candidateSeason, minimumNumberHomeGames)
	#Assemble an array of the ids of all the teams in the league
  	arrayLeagueTeamIds = Array.new
  	arrayLeagueTeamIds = leagueTeamIds

  	#Sort the team array by ID number
  	arrayLeagueTeamIds = arrayLeagueTeamIds.sort

  	#Create a new array the same length as Team.count
  	homeGamesCountArray = Array.new(10, 0) #=> [0, 0, 0]

  	#Loop through all the home teams
	(0..candidateSeason.length-1).step(2) do |i|
		homeTeamId = candidateSeason[i]
		#find this hometeam index in sorted team array, and use that to increment the element of the homegames count array
		(0..arrayLeagueTeamIds.length-1).each do |j|
			if homeTeamId==arrayLeagueTeamIds[j]
				homeGamesCountArray[j] = homeGamesCountArray[j] + 1
			end
		end
	end

	nResult = true
	(0..homeGamesCountArray.length-1).each do |i|
		if homeGamesCountArray[i]<minimumNumberHomeGames 
			nResult = false;
		end
	end
	nResult
end

def self.gx
	printf("TCYFL Season generator:\n");

	#These variables should be put into the model/database
	weeks = 9
  	numberGamesEachWeek = Team.count/2
  	totalNumberGames = weeks * numberGamesEachWeek;

  	#Create a placeholder for the season
  	candidateSeason = Array.new

  	#Make a list of all teams in the league
  	arrayLeagueTeamIds = Array.new
  	Team.all.each do |i|
  		arrayLeagueTeamIds << i.id 
  	end

  	#Randomly create seasons until one is found that passes all business criteria
  	seasonPassesAllCriteria=false
  	while seasonPassesAllCriteria==false
  		seasonPassesAllCriteria=true
		candidateSeason = Game.generate_candidate_season(arrayLeagueTeamIds)

		#Does each team have 4 or 5 home games
		nResult = Game.meets_minimum_home_games(arrayLeagueTeamIds,candidateSeason,4)
		if nResult==false
			seasonPassesAllCriteria=false
			printf("Failed minimum home games (retrying)\n");
		end

		#Is the season schedule-able wrt to home games?
		nResult = Game.home_games_are_scheduleable(arrayLeagueTeamIds,candidateSeason)
		if nResult==false
			seasonPassesAllCriteria=false
			printf("Failed scheduling home game fields (retrying)\n");
		end

	end


	# At this point, the season is declared valid.
	# Print the candidate season to review in irb
	printf("The candidate season is: %d length\n",candidateSeason.length);
	(0..weeks-1).each do |i|
	  	(0..numberGamesEachWeek-1).each do |j|
	  		m  = ((i*numberGamesEachWeek)+j)*2
  			#printf("%d %d\n",candidateSeason[m],candidateSeason[m+1]);
  			printf("%s %s vs %s %s\n",Team.find(candidateSeason[m]).community,Team.find(candidateSeason[m]).namecolor, Team.find(candidateSeason[m+1]).community,Team.find(candidateSeason[m+1]).namecolor)
  		end
  		printf("\n")
  	end
  	candidateSeason
end

  def self.reset_games
  	games = Game.all
  	games.each do |game|
  		game.destroy
  	end
  end

end
