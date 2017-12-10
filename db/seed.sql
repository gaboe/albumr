insert into Genres(Name) values ('Rap');

insert into Authors(FirstName,LastName) 
values ('Kendrick','Lammar');


insert into Albums(Name,AuthorID,ReleaseYear,GenreID)
VALUES ('To Pimp a Butterfly',(select Authors.AuthorID from Authors where Authors.FirstName = 'Kendrick' and Authors.LastName= 'Lammar'),2015,(select Genres.GenreID from Genres where Genres.Name = 'Rap'));

insert into Songs(Name,AlbumID) values('Wesleys Theory',(select Albums.AlbumID from Albums where Albums.Name = 'To Pimp a Butterfly'));
insert into Songs(Name,AlbumID) values('For Free?',(select Albums.AlbumID from Albums where Albums.Name = 'To Pimp a Butterfly'));
insert into Songs(Name,AlbumID) values('King Kunta',(select Albums.AlbumID from Albums where Albums.Name = 'To Pimp a Butterfly'));
insert into Songs(Name,AlbumID) values('These Walls',(select Albums.AlbumID from Albums where Albums.Name = 'To Pimp a Butterfly'));
insert into Songs(Name,AlbumID) values('Alright',(select Albums.AlbumID from Albums where Albums.Name = 'To Pimp a Butterfly'));
insert into Songs(Name,AlbumID) values('i',(select Albums.AlbumID from Albums where Albums.Name = 'To Pimp a Butterfly'));
insert into Songs(Name,AlbumID) values('Mortal Man',(select Albums.AlbumID from Albums where Albums.Name = 'To Pimp a Butterfly'));