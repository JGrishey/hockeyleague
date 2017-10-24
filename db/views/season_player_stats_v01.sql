SELECT user_id, games.season_id, sum(goals) "goals", sum(assists) "assists", sum(goals) + sum(assists) "points", COUNT(*) "games_played", sum(plus_minus) "plus_minus", sum(pim) "pim", sum(ppg) "ppg", sum(shg) "shg", sum(shots) "shots", sum(hits) "hits", sum(goals) / NULLIF(sum(shots),0) "sh_per", sum(fow) "fow", sum(fot) "fot", sum(fow) / NULLIF(sum(fot),0) "fo_per", sum(goals_against) "ga", sum(shots_against) "sa", (sum(shots_against) - sum(goals_against)) / NULLIF(sum(shots_against), 0) "sv_per", sum(goals_against) / NULLIF(count(CASE WHEN position = 'G' THEN 1 END), 0) "gaa", count(CASE WHEN goals_against = 0 AND position = 'G' THEN 1 END) "so", sum(CASE WHEN position = 'G' THEN assists ELSE 0 END) "g_assists", sum(CASE WHEN position = 'G' THEN goals ELSE 0 END) "g_goals"
FROM stat_lines inner join games on stat_lines.game_id = games.id
WHERE final=true
GROUP BY user_id, games.season_id
ORDER BY user_id, games.season_id;
