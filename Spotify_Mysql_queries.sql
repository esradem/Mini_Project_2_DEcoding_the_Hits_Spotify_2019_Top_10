DROP DATABASE IF EXISTS spotify;
CREATE DATABASE spotify;
USE spotify;

DROP TABLE IF EXISTS Artists;
CREATE TABLE artists (
	artist_id INT PRIMARY KEY AUTO_INCREMENT,
    artist_name VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS Genres;
CREATE TABLE Genres (
    genre_id INT PRIMARY KEY AUTO_INCREMENT,
    genre_name VARCHAR(50) NOT NULL
);

-- Create Songs table
DROP TABLE IF EXISTS Track;
CREATE TABLE Track (
    track_id INT PRIMARY KEY AUTO_INCREMENT,
    track_name VARCHAR(100) NOT NULL,
    artist_id INT NOT NULL,
    genre_id INT NOT NULL,
    bpm INT,
    energy INT,
    danceability INT,
    loudness_db DECIMAL(5,2),  
    liveness INT,
    valence INT,
    length INT,
    acousticness INT,
    speechiness INT,
    popularity INT,
    FOREIGN KEY (artist_id) REFERENCES Artists(artist_id),
    FOREIGN KEY (genre_id) REFERENCES Genres(genre_id)

);
show tables;
select * from artists;
select*from genres;
select *from track; 
-- Most common genre for high valence + high danceability
SELECT g.genre_name, COUNT(*) AS track_count
FROM Track t
JOIN Genres g ON t.genre_id = g.genre_id
WHERE t.valence > 80 AND t.danceability > 70
GROUP BY g.genre_name
ORDER BY track_count DESC;

-- MOst Popular tracks relation with high energy and dancebility
SELECT 
    track_id,
    track_name,
    popularity,
    energy,
    danceability
FROM Track
ORDER BY popularity DESC
LIMIT 10;
-- Which genres are dominant in terms of popularity, high energy and high danceability 
SELECT g.genre_name,COUNT(*) AS track_count,
AVG(t.popularity) AS average_popularity,
AVG(t.danceability) AS average_danceability,
AVG(t.energy) AS average_energy
FROM Track t
JOIN Genres g ON g.genre_id=t.genre_id
GROUP BY g.genre_name
ORDER BY track_count DESC
LIMIT 10;