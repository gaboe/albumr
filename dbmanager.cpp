#include "dbmanager.h"
#include <QtSql>
#include <QStandardPaths>
DbManager::DbManager()
{

}

void DbManager::open()
{
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    auto location = QStandardPaths::writableLocation(QStandardPaths::ApplicationsLocation) + "/albumr.db";
    qInfo() << location;
    db.setDatabaseName(location);
    db.open();


    if (!db.open()){
        qInfo() << db.lastError();
    }
    QStringList tables = db.tables();

    if (!tables.contains("albums", Qt::CaseInsensitive)) {
       init(db);

    }
}

void DbManager::init(QSqlDatabase db)
{
    QSqlQuery query;
    int res=query.exec(getInitScriptForAuthors());
    qDebug() << res;
    qDebug() << "exec :" << query.lastError();
     res=query.exec(getInitScriptForGenres());
    qDebug() << res;
    qDebug() << "exec :" << query.lastError();
     res=query.exec(getInitScriptForAlbums());
    qDebug() << res;
    qDebug() << "exec :" << query.lastError();
     res=query.exec(getInitScriptForSongs());
    qDebug() << res;
    qDebug() << "exec :" << query.lastError();
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
            " [ReleaseYear] INTEGER not null," \
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
