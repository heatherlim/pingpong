  Table.delete_all
  Player.delete_all
  Game.delete_all

  Table.create(
    name: "Hopper"
  )


  Table.create(
    name: "On Top of the Freedom Tower"
  )

  Table.create(
    name: "Bottom of the Gowanus Canal"
  )

  Course.create(name: "Web 0915")
  Course.create(name: "Web 0715")
  Course.create(name: "IOS 0915")

  100.times do  
    id = rand(1..3)
    Player.create(
      name: Faker::Name.name, 
      email: Faker::Internet.email,
      password_digest: "password123",
      remember_digest: "password123",
      course_id: id
    )
  end

    sample1 = (1..50).to_a
    sample2 = (51..100).to_a
    sample3 = (1..25).to_a
    sample4 = (26..50).to_a

  25.times do 
    Game.new.tap do |game|

      game.match_time = Faker::Date.between(4.weeks.ago, Date.today)
      game.table_id = rand(1..3)

      team1_first_player = sample1.pop
      team1_second_player = sample2.pop
      team2_first_player = sample1.pop
      team2_second_player = sample2.pop

      team1 = game.teams.build
      team2 = game.teams.build

      team1.player_ids = [team1_first_player, team1_second_player]
      team2.player_ids = [team2_first_player, team2_second_player]

      game.save

      # game.team_games.first.score = rand(1..21)

      # game.team_games.last.score = rand(1..21)

      # game.save
      # game.team_games.each(&:save)
    end
  end

    25.times do 
      Game.new.tap do |game|

        game.match_time = Faker::Date.between(4.weeks.ago, Date.today)
        game.table_id = rand(1..3)

        team1_first_player = sample3.pop

        team2_first_player = sample4.pop


        team1 = game.teams.build
        team2 = game.teams.build

        team1.player_ids = [team1_first_player]
        team2.player_ids = [team2_first_player]

        game.save
        
        # game.team_games.first.score = rand(1..21)
        # game.team_games.last.score = rand(1..21)

        # game.save
        # game.team_games.each(&:save)
      end
    end

    sample1 = (1..50).to_a
    sample2 = (51..100).to_a
    sample3 = (1..25).to_a
    sample4 = (26..50).to_a

3.times do
  25.times do 
    Game.new.tap do |game|

      game.match_time = Faker::Date.between(4.weeks.ago, Date.today)
      game.table_id = rand(1..3)

      team1_first_player = sample1.shuffle.pop
      team1_second_player = sample2.shuffle.pop
      team2_first_player = sample1.shuffle.pop
      team2_second_player = sample2.shuffle.pop

      team1 = Team.find_or_create_by_player_ids([team1_first_player, team1_second_player])
      team2 = Team.find_or_create_by_player_ids([team2_first_player, team2_second_player])
      team_game1 = game.team_games.build
      team_game2 = game.team_games.build
      team_game1.team = team1
      team_game2.team = team2
      team_game1.save
      team_game2.save

      game.save

      # game.team_games.first.score = rand(1..21)

      # game.team_games.last.score = rand(1..21)

      # game.save
      # game.team_games.each(&:save)
    end
  end

    25.times do 
      Game.new.tap do |game|

        game.match_time = Faker::Date.between(4.weeks.ago, Date.today)
        game.table_id = rand(1..3)

        team1_first_player = sample3.shuffle.pop

        team2_first_player = sample4.shuffle.pop

        team1 = Team.find_or_create_by_player_ids([team1_first_player, 0])
        team2 = Team.find_or_create_by_player_ids([team2_first_player, 0])

        team_game1 = game.team_games.build
        team_game2 = game.team_games.build
        team_game1.team = team1
        team_game2.team = team2
        team_game1.save
        team_game2.save
        game.save
        
        # game.team_games.first.score = rand(1..21)
        # game.team_games.last.score = rand(1..21)

        # game.save
        # game.team_games.each(&:save)
      end
    end
  end

    TeamGame.all.each do |team_game|
      team_game.score = rand(1..21)
      team_game.save
    end



