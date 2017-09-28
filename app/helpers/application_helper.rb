module ApplicationHelper
    def link_to_add_goals(name, f, association, players, team_id)
        new_object = f.object.send(association).klass.new
        id = new_object.object_id
        goals = f.fields_for(association, new_object, child_index: id) do |builder|
            render("goalentry", f: builder, players: players, team_id: team_id)
        end
        link_to(name, '#', class: "add_goals", data: {id: id, goals: goals.gsub("\n", "")})
    end

    def link_to_add_penalties(name, f, association, players, team_id)
        new_object = f.object.send(association).klass.new
        id = new_object.object_id
        penalties = f.fields_for(association, new_object, child_index: id) do |builder|
            render("penaltyentry", f: builder, players: players, team_id: team_id)
        end
        link_to(name, '#', class: "add_penalties", data: {id: id, penalties: penalties.gsub("\n", "")})
    end

    def link_to_add_home_players(name, f, association)
        new_object = f.object.send(association).klass.new
        id = new_object.object_id
        players = f.fields_for(association, new_object, child_index: id) do |builder|
            render("home_playerentry", f: builder)
        end
        link_to(name, '#', class: "add_players", data: {id: id, players: players.gsub("\n", "")})
    end

    def link_to_add_away_players(name, f, association)
        new_object = f.object.send(association).klass.new
        id = new_object.object_id
        players = f.fields_for(association, new_object, child_index: id) do |builder|
            render("away_playerentry", f: builder)
        end
        link_to(name, '#', class: "add_players", data: {id: id, players: players.gsub("\n", "")})
    end

    def link_to_add_players(name, f, association)
        new_object = f.object.send(association).klass.new
        id = new_object.object_id
        players = f.fields_for(association, new_object, child_index: id) do |builder|
            render("playerentry", f: builder)
        end
        link_to(name, '#', class: "add_players", data: {id: id, players: players.gsub("\n", "")})
    end

    def link_to_add_movements(name, f, association, players, teams)
        new_object = f.object.send(association).klass.new
        id = new_object.object_id
        movements = f.fields_for(association, new_object, child_index: id) do |builder|
            render("movement_entry", f: builder, players: players, teams: teams)
        end
        link_to(name, '#', class: "add_movements", data: {id: id, movements: movements.gsub("\n", "")})
    end

    def get_avatar (user)
        if user
            if user.avatar.exists?
                user.avatar.url(:small)
            else
                image_path("default-user.png")
            end
        end
    end

    def get_logo (team)
        if team.logo.exists?
            team.logo.url
        else
            image_path("MooseLogo.png")
        end
    end

    def small_image (user)
        link_to("<img class='small-img' src=#{get_avatar(user)}/>".html_safe, profile_path(user.user_name))
    end

    def banner_options
        [
            ["", "https://nhl.bamcontent.com/images/actionshots/8470638.jpg"],
            ["Ryan Getzlaf", "https://nhl.bamcontent.com/images/actionshots/8470612.jpg"],
            ["Cam Fowler", "https://nhl.bamcontent.com/images/actionshots/8475764.jpg"],
            ["John Gibson", "https://nhl.bamcontent.com/images/actionshots/8476434.jpg"],
            ["Max Domi", "https://nhl.bamcontent.com/images/actionshots/8477503.jpg"],
            ["Oliver Ekman-Larsson", "https://nhl.bamcontent.com/images/actionshots/8475171.jpg"],
            ["Louis Domingue", "https://nhl.bamcontent.com/images/actionshots/8475839.jpg"],
            ["Patrice Bergeron", "https://nhl.bamcontent.com/images/actionshots/8470638.jpg"],
            ["Charlie McAvoy", "https://nhl.bamcontent.com/images/actionshots/8479325.jpg"],
            ["Tuukka Rask", "https://nhl.bamcontent.com/images/actionshots/8471695.jpg"],
            ["Jack Eichel", "https://nhl.bamcontent.com/images/actionshots/8478403.jpg"],
            ["Rasmus Ristolainen", "https://nhl.bamcontent.com/images/actionshots/8477499.jpg"],
            ["Robin Lehner", "https://nhl.bamcontent.com/images/actionshots/8475215.jpg"],
            ["Johnny Gaudreau", "https://nhl.bamcontent.com/images/actionshots/8476346.jpg"],
            ["Mark Giordano", "https://nhl.bamcontent.com/images/actionshots/8470966.jpg"],
            ["Mike Smith", "https://nhl.bamcontent.com/images/actionshots/8469608.jpg"],
            ["Jeff Skinner", "https://nhl.bamcontent.com/images/actionshots/8475784.jpg"],
            ["Justin Faulk", "https://nhl.bamcontent.com/images/actionshots/8475753.jpg"],
            ["Cam Ward", "https://nhl.bamcontent.com/images/actionshots/8470320.jpg"],
            ["Patrick Kane", "https://nhl.bamcontent.com/images/actionshots/8474141.jpg"],
            ["Duncan Keith", "https://nhl.bamcontent.com/images/actionshots/8470281.jpg"],
            ["Corey Crawford", "https://nhl.bamcontent.com/images/actionshots/8470645.jpg"],
            ["Nathan Mackinnon", "https://nhl.bamcontent.com/images/actionshots/8477492.jpg"],
            ["Tyson Barrie", "https://nhl.bamcontent.com/images/actionshots/8475197.jpg"],
            ["Semyon Varlamov", "https://nhl.bamcontent.com/images/actionshots/8473575.jpg"],
            ["Cam Atkinson", "https://nhl.bamcontent.com/images/actionshots/8474715.jpg"],
            ["Zach Werenski", "https://nhl.bamcontent.com/images/actionshots/8478460.jpg"],
            ["Sergei Bobrovsky", "https://nhl.bamcontent.com/images/actionshots/475683.jpg"],
            ["Jamie Benn", "https://nhl.bamcontent.com/images/actionshots/8473994.jpg"],
            ["John Klingberg", "https://nhl.bamcontent.com/images/actionshots/8475906.jpg"],
            ["Ben Bishop", "https://nhl.bamcontent.com/images/actionshots/8471750.jpg"],
            ["Henrik Zetterberg", "https://nhl.bamcontent.com/images/actionshots/8468083.jpg"],
            ["Niklas Kronwall", "https://nhl.bamcontent.com/images/actionshots/8468509.jpg"],
            ["Petr Mrazek", "https://nhl.bamcontent.com/images/actionshots/8475852.jpg"],
            ["Connor McDavid", "https://nhl.bamcontent.com/images/actionshots/8478402.jpg"],
            ["Adam Larsson", "https://nhl.bamcontent.com/images/actionshots/8476457.jpg"],
            ["Cam Talbot", "https://nhl.bamcontent.com/images/actionshots/8475660.jpg"],
            ["Aleksander Barkov", "https://nhl.bamcontent.com/images/actionshots/8477493.jpg"],
            ["Aaron Ekblad", "https://nhl.bamcontent.com/images/actionshots/8477932.jpg"],
            ["Roberto Luongo", "https://nhl.bamcontent.com/images/actionshots/8466141.jpg"],
            ["Anze Kopitar", "https://nhl.bamcontent.com/images/actionshots/8471685.jpg"],
            ["Drew Doughty", "https://nhl.bamcontent.com/images/actionshots/8474563.jpg"],
            ["Jonathan Quick", "https://nhl.bamcontent.com/images/actionshots/8471734.jpg"],
            ["Charlie Coyle", "https://nhl.bamcontent.com/images/actionshots/8475745.jpg"],
            ["Ryan Suter", "https://nhl.bamcontent.com/images/actionshots/8470600.jpg"],
            ["Devan Dubnyk", "https://nhl.bamcontent.com/images/actionshots/8471227.jpg"],
            ["Max Pacioretty", "https://nhl.bamcontent.com/images/actionshots/8474157.jpg"],
            ["Shea Weber", "https://nhl.bamcontent.com/images/actionshots/8470642.jpg"],
            ["Carey Price", "https://nhl.bamcontent.com/images/actionshots/8471679.jpg"],
            ["Filip Forsberg", "https://nhl.bamcontent.com/images/actionshots/8476887.jpg"],
            ["P.K. Subban", "https://nhl.bamcontent.com/images/actionshots/8474056.jpg"],
            ["Pekka Rinne", "https://nhl.bamcontent.com/images/actionshots/8471469.jpg"],
            ["Kyle Palmieri", "https://nhl.bamcontent.com/images/actionshots/8475151.jpg"],
            ["Andy Greene", "https://nhl.bamcontent.com/images/actionshots/8472382.jpg"],
            ["Cory Schneider", "https://nhl.bamcontent.com/images/actionshots/8471239.jpg"],
            ["John Tavares", "https://nhl.bamcontent.com/images/actionshots/8475166.jpg"],
            ["Nick Leddy", "https://nhl.bamcontent.com/images/actionshots/8475181.jpg"],
            ["Thomas Greiss", "https://nhl.bamcontent.com/images/actionshots/8471306.jpg"],
            ["Mats Zuccarello", "https://nhl.bamcontent.com/images/actionshots/8475692.jpg"],
            ["Ryan McDonagh", "https://nhl.bamcontent.com/images/actionshots/8474151.jpg"],
            ["Henrik Lundqvist", "https://nhl.bamcontent.com/images/actionshots/8468685.jpg"],
            ["Mike Hoffman", "https://nhl.bamcontent.com/images/actionshots/8474884.jpg"],
            ["Erik Karlsson", "https://nhl.bamcontent.com/images/actionshots/8474578.jpg"],
            ["Craig Anderson", "https://nhl.bamcontent.com/images/actionshots/8467950.jpg"],
            ["Claude Giroux", "https://nhl.bamcontent.com/images/actionshots/8473512.jpg"],
            ["Ivan Provorov", "https://nhl.bamcontent.com/images/actionshots/8478500.jpg"],
            ["Michael Neuvirth", "https://nhl.bamcontent.com/images/actionshots/8473607.jpg"],
            ["Sidney Crosby", "https://nhl.bamcontent.com/images/actionshots/8471675.jpg"],
            ["Kris Letang", "https://nhl.bamcontent.com/images/actionshots/8471724.jpg"],
            ["Matt Murray", "https://nhl.bamcontent.com/images/actionshots/8476899.jpg"],
            ["Joe Thornton", "https://nhl.bamcontent.com/images/actionshots/8466138.jpg"],
            ["Brent Burns", "https://nhl.bamcontent.com/images/actionshots/8470613.jpg"],
            ["Martin Jones", "https://nhl.bamcontent.com/images/actionshots/8474889.jpg"],
            ["Vladimir Tarasenko", "https://nhl.bamcontent.com/images/actionshots/8475765.jpg"],
            ["Alex Pietrangelo", "https://nhl.bamcontent.com/images/actionshots/8474565.jpg"],
            ["Jake Allen", "https://nhl.bamcontent.com/images/actionshots/8474596.jpg"],
            ["Nikita Kucherov", "https://nhl.bamcontent.com/images/actionshots/8476453.jpg"],
            ["Victor Hedman", "https://nhl.bamcontent.com/images/actionshots/8475167.jpg"],
            ["Andrei Vasilevskiy", "https://nhl.bamcontent.com/images/actionshots/8476883.jpg"],
            ["Auston Matthews", "https://nhl.bamcontent.com/images/actionshots/8479318.jpg"],
            ["Morgan Rielly", "https://nhl.bamcontent.com/images/actionshots/8476853.jpg"],
            ["Frederik Andersen", "https://nhl.bamcontent.com/images/actionshots/8475883.jpg"],
            ["Henrik Sedin", "https://nhl.bamcontent.com/images/actionshots/8467876.jpg"],
            ["Christopher Tanev", "https://nhl.bamcontent.com/images/actionshots/8475690.jpg"],
            ["Jacob Markstrom", "https://nhl.bamcontent.com/images/actionshots/8474593.jpg"],
            ["Alex Ovechkin", "https://nhl.bamcontent.com/images/actionshots/8471214.jpg"],
            ["John Carlson", "https://nhl.bamcontent.com/images/actionshots/8474590.jpg"],
            ["Braden Holtby", "https://nhl.bamcontent.com/images/actionshots/8474651.jpg"],
            ["Mark Scheifele", "https://nhl.bamcontent.com/images/actionshots/8476460.jpg"],
            ["Dustin Byfuglien", "https://nhl.bamcontent.com/images/actionshots/8470834.jpg"],
            ["Connor Hellebucyk", "https://nhl.bamcontent.com/images/actionshots/8476945.jpg"],
        ]
    end
end
