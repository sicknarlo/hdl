require 'mechanize'

class Scraper

  BASE_URL = "http://games.espn.go.com/ffl/scoreboard?leagueId=143124&matchupPeriodId="

  def initialize

    @agent = Mechanize.new

  end

  def scrape_schedule(id)
    url = buildScheduleUrl(id)
    page = @agent.get(url)
  end

  def scrape_names
    12.times do |i|
      id = i+1
      url = buildNameUrl(id)
      page = @agent.get(url)
      owners = page.search('//*[@id="content"]/div/div[5]/div/div/div[3]/div[1]/div[2]/div[1]/ul[2]').text
      team = Team.find(id)
      name = page.search('//*[@id="content"]/div/div[5]/div/div/div[3]/div[1]/div[2]/div[1]/h3/text()').text[0..-2]
      if team.name != name
        team.name = name
        team.owners = owners
        p "Updating Name to" + name
        team.save
      end
    end
  end

  def scrape_week(week)

    # Update Team Names
    scrape_names

    # Scrape Scores
    scraped_teams = []

    12.times do |i|

      # End loop if all matches scraped
      break if scraped_teams.length == 12

      # Team id is index + 1
      id = i+1

      # Build match url
      url = buildMatchUrl(id, week)
      page = @agent.get(url)

      t1name = page.search('//*[@id="teamInfos"]/div[1]/div/div[2]/div[1]/b').text.to_s
      t2name = page.search('//*[@id="teamInfos"]/div[2]/div/div[2]/div[1]/b').text.to_s
      # Find Teams by name
      team1 = Team.where(name: t1name).first
      team2 = Team.where(name: t2name).first

      #if either team already scraped, skipped; else add to scraped_teams
      if scraped_teams.include?(team1) || scraped_teams.include?(team2)
        next
      else
        scraped_teams << team1
        scraped_teams << team2
      end

      t1_score = page.search('//*[@id="content"]/div/div[5]/div/div/div/div[5]/div[1]/div').text.to_f
      t2_score = page.search('//*[@id="content"]/div/div[5]/div/div/div/div[6]/div[1]/div').text.to_f

      # Create new match
      match = Match.create

      match.season = 2015

      # Create Scores
      t1s = Score.create
      t1s.team_id = team1.id
      t1s.score = t1_score
      t1s.match_id = match.id

      t2s = Score.create
      t2s.team_id = team1.id
      t2s.score = t2_score
      t2s.match_id = match.id


      match.team1_score = t1s.id
      match.team2_score = t2s.id
      match.post_season = false
      match.week = week
      match.save
      t1s.save
      t2s.save


      # Update streaks
      if t1_score > t2_score
        winner = team1
        team2.current_streak = 0
        team1.current_streak += 1
        team1.best_streak = team1.current_streak if team1.current_streak > team1.best_streak
      elsif t1_score < t2_score
        winner = team2
        team1.current_streak = 0
        team2.current_streak += 1
        team2.best_streak = team2.current_streak if team2.current_streak > team2.best_streak
      else
        team1.current_streak = 0
        team2.current_streak = 0
      end

      team1.save
      team2.save

    end # End loop

  end

  def buildNameUrl(id)
    "http://games.espn.go.com/ffl/clubhouse?leagueId=143124&teamId=" + id.to_s + "&seasonId=2015"
  end

  def buildScheduleUrl(id)
    "http://games.espn.go.com/ffl/schedule?leagueId=143124&teamId=" + id.to_s
  end

  def buildMatchUrl(id, week)
    part1 = "http://games.espn.go.com/ffl/boxscorequick?leagueId=143124&teamId="
    part2 = "&scoringPeriodId="
    part3 = "&seasonId=2015&view=scoringperiod&version=quick"
    part1 + id.to_s + part2 + week.to_s + part3
  end

end