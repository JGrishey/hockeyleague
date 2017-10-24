SELECT *
FROM games
WHERE final=true
GROUP BY home_id, away_id, games.id
ORDER BY season_id;