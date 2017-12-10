create table Authors(
    [AuthorID]  INTEGER PRIMARY KEY AUTOINCREMENT,
    [FirstName] nvarchar(150) not null,
    [LastName] nvarchar(150) not null
);

create table Genres(
    [GenreID] INTEGER PRIMARY KEY AUTOINCREMENT,
    [Name] nvarchar(300) not null    
);

create table Albums(
    [AlbumID] INTEGER PRIMARY KEY AUTOINCREMENT,
    [AuthorID] INTEGER not null,
    [Name] nvarchar(300) not null,
    [ReleaseYear] INTEGER not null,
    [GenreID] INTEGER,

    foreign key(AuthorID) references Authors(AuthorID),
    foreign key(GenreID) references Genres(GenreID)
);

create table Songs(
    [SongID] INTEGER PRIMARY KEY AUTOINCREMENT,
    [Name] NVARCHAR(300) NOT NULL,
    [AlbumID] INTEGER NOT NULL,

    foreign key(AlbumID) references Albums(AlbumID)
);