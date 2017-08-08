module ApplicationHelper
    def link_to_add_goals(name, f, association, players)
        new_object = f.object.send(association).klass.new
        id = new_object.object_id
        goals = f.fields_for(association, new_object, child_index: id) do |builder|
            render("goalentry", f: builder, players: players)
        end
        link_to(name, '#', class: "add_goals", data: {id: id, goals: goals.gsub("\n", "")})
    end

    def link_to_add_penalties(name, f, association, players)
        new_object = f.object.send(association).klass.new
        id = new_object.object_id
        penalties = f.fields_for(association, new_object, child_index: id) do |builder|
            render("penaltyentry", f: builder, players: players)
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
end
