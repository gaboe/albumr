#include "dbmanager.h"
#include <QtSql>
#include <QStandardPaths>
DbManager::DbManager()
{

}

bool DbManager::open()
{
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    auto location = QStandardPaths::writableLocation(QStandardPaths::ApplicationsLocation) + "/albumr.db";
    qInfo() << "Db location: " << location;
    db.setDatabaseName(location);
    db.open();


    if (!db.open()){
        qInfo() << db.lastError();
        return false;
    }
    QStringList tables = db.tables();

    if (!tables.contains("albums", Qt::CaseInsensitive)) {
       init();
    }

    QSqlQuery query("SELECT COUNT(*) FROM Authors");
    if (query.next()) {
        int rows = query.value(0).toInt();
        if(rows < 1)
            seed();
    }
    return true;
}

void DbManager::seed()
{
    qInfo() << "Seeding db";
    QSqlQuery query;
    query.exec("insert into Genres(Name) values ('Rap');");
    query.exec("insert into Genres(Name) values ('R&B');");
    query.exec("insert into Authors(FirstName,LastName) values ('Kendrick','Lammar');");
    query.exec("insert into Authors(FirstName,LastName) values ('Kanye','West');");
    query.exec("insert into Authors(FirstName,LastName) values ('Frank','Ocean');");

    query.exec("insert into Albums(Name,AuthorID,Year,GenreID) VALUES ('To Pimp a Butterfly',(select Authors.AuthorID from Authors where Authors.FirstName = 'Kendrick' and Authors.LastName= 'Lammar'),2015,(select Genres.GenreID from Genres where Genres.Name = 'Rap'));");
    query.exec("insert into Albums(Name,AuthorID,Year,GenreID) VALUES ('Yeezus',(select Authors.AuthorID from Authors where Authors.FirstName = 'Kanye' and Authors.LastName= 'West'),2013,(select Genres.GenreID from Genres where Genres.Name = 'Rap'));");
    query.exec("insert into Albums(Name,AuthorID,Year,GenreID) VALUES ('Blonde',(select Authors.AuthorID from Authors where Authors.FirstName = 'Frank' and Authors.LastName= 'Ocean'),2016,(select Genres.GenreID from Genres where Genres.Name = 'R&B'));");
    query.exec("insert into Albums(Name,AuthorID,Year,GenreID) VALUES ('DAMN.',(select Authors.AuthorID from Authors where Authors.FirstName = 'Kendrick' and Authors.LastName= 'Lammar'),2015,(select Genres.GenreID from Genres where Genres.Name = 'Rap'));");

    query.exec("insert into Songs(Name,AlbumID) values('Wesleys Theory',(select Albums.AlbumID from Albums where Albums.Name = 'To Pimp a Butterfly'));");
    query.exec("insert into Songs(Name,AlbumID) values('For Free?',(select Albums.AlbumID from Albums where Albums.Name = 'To Pimp a Butterfly'));");
    query.exec("insert into Songs(Name,AlbumID) values('King Kunta',(select Albums.AlbumID from Albums where Albums.Name = 'To Pimp a Butterfly'));");
    query.exec("insert into Songs(Name,AlbumID) values('These Walls',(select Albums.AlbumID from Albums where Albums.Name = 'To Pimp a Butterfly'));");
    query.exec("insert into Songs(Name,AlbumID) values('Alright',(select Albums.AlbumID from Albums where Albums.Name = 'To Pimp a Butterfly'));");
    query.exec("insert into Songs(Name,AlbumID) values('i',(select Albums.AlbumID from Albums where Albums.Name = 'To Pimp a Butterfly'));");
    query.exec("insert into Songs(Name,AlbumID) values('Mortal Man',(select Albums.AlbumID from Albums where Albums.Name = 'To Pimp a Butterfly'));");

    query.exec("insert into Songs(Name,AlbumID) values('On sight',(select Albums.AlbumID from Albums where Albums.Name = 'Yeezus'));");
    query.exec("insert into Songs(Name,AlbumID) values('I am a God',(select Albums.AlbumID from Albums where Albums.Name = 'Yeezus'));");

    query.exec("insert into Songs(Name,AlbumID) values('Nikes',(select Albums.AlbumID from Albums where Albums.Name = 'Blonde'));");
    query.exec("insert into Songs(Name,AlbumID) values('Nights',(select Albums.AlbumID from Albums where Albums.Name = 'Blonde'));");
    query.exec("insert into Songs(Name,AlbumID) values('Pink and Yellow',(select Albums.AlbumID from Albums where Albums.Name = 'Blonde'));");

    query.exec("insert into Songs(Name,AlbumID) values('Humble',(select Albums.AlbumID from Albums where Albums.Name = 'DAMN.'));");
    query.exec("insert into Songs(Name,AlbumID) values('Duckworth',(select Albums.AlbumID from Albums where Albums.Name = 'DAMN.'));");

}

void DbManager::init()
{
    qInfo() << "Initializing db";
    QSqlQuery query;
    int res=query.exec(getInitScriptForAuthors());

     res=query.exec(getInitScriptForGenres());

     res=query.exec(getInitScriptForAlbums());

     res=query.exec(getInitScriptForSongs());

}

QString DbManager::getInitScriptForAuthors()
{
    return "create table Authors( " \
           "[AuthorID]  INTEGER PRIMARY KEY AUTOINCREMENT," \
           "[FirstName] nvarchar(150) not null," \
           "[LastName] nvarchar(150) not null" \
           ");" \
            ;
}

QString DbManager::getInitScriptForGenres()
{
    return   "create table Genres(" \
             "    [GenreID] INTEGER PRIMARY KEY AUTOINCREMENT," \
             "   [Name] nvarchar(300) not null" \
             ");" \
            ;
}

QString DbManager::getInitScriptForAlbums()
{
    return
            " create table Albums(" \
            "    [AlbumID] INTEGER PRIMARY KEY AUTOINCREMENT," \
            "   [AuthorID] INTEGER not null," \
            "  [Name] nvarchar(300) not null," \
            " [Year] INTEGER not null," \
            " [GenreID] INTEGER," \

            "     foreign key(AuthorID) references Authors(AuthorID)," \
            "    foreign key(GenreID) references Genres(GenreID)" \
            ");" \

            ;
}

QString DbManager::getInitScriptForSongs()
{
    return  " create table Songs(" \
            "    [SongID] INTEGER PRIMARY KEY AUTOINCREMENT," \
            "   [Name] NVARCHAR(300) NOT NULL," \
            "  [AlbumID] INTEGER NOT NULL," \

            " foreign key(AlbumID) references Albums(AlbumID)" \
            ");" \
            ;
}
