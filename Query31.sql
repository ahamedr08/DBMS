______________________________________________________________________________________________________________________
Problem Statement :

Best Scores

You are working on a table that stores the game scores of multiple players.
Each player has a nickname associated with them. The table Scores has two columns, the nickname and the score.
The table can store multiple rows for each player, which correspond to scores they earned during multiple games.
You need to find the best score for each player and output the result sorted by the best score in descending order.
The output should have the nickname column, followed by the best score column called 'best'.

Hint: Group the table by the nickname column, then calculate the max score for each player.
______________________________________________________________________________________________________________________
Solution :

SELECT nickname,MAX(score) AS best
FROM Scores 
GROUP BY nickname
ORDER BY best DESC