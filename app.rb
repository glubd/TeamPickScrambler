require 'sinatra'

enable :sessions

get "/" do
  erb :index, layout: :application
end

post "/teams" do

  #contestants array

  contestants = params[:list].split(",").shuffle
  num_teams = params[:num_teams].to_i

  session[:contestants] = params[:list]
  session[:num_teams] = params[:num_teams]

  if (contestants.length < 1)

    @result = "You should have at least one person"

  elsif (num_teams < 1)

    @result = "You must have at least one team"
    
  elsif (contestants.length < num_teams)

    @result = "Number of teams must not be greater than number of contestants"
  
  else
  
#    array_teams = []
#
#    for i in 1..num_teams
#        array_teams << "#{i.to_s}"
#    end

    hash_teams = Hash[("1"..num_teams.to_s).to_a.map {|x| [x,[]]}]

    d = contestants.length / num_teams
    m = contestants.length % num_teams
    i = 0

    #loop through hash
    hash_teams.each do |team,members|
      d.times do
        hash_teams[team] << contestants[i] 
        i += 1
      end
      if(m>0)
        hash_teams[team] << contestants[i] 
        m -= 1
        i += 1
      end
    end 

    @result = hash_teams

  end

  erb :index, layout: :application
end
