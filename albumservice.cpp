#include "albumservice.h"
#include "album.h"
#include "song.h"
#include <QObject>
#include <QSqlQuery>
#include <QSqlRecord>
#include <QVariant>

AlbumService::AlbumService(QObject *parent) : QObject(parent)
{

}

QList<QVariant> AlbumService::getAlbums()
{
    QSqlQuery query;
    QString queryString = "SELECT Albums.AlbumID, Albums.Name, Albums.AuthorID, Albums.Year, Albums.GenreID, Authors.FirstName, Authors.LastName,  Genres.Name as GenreName FROM Albums JOIN Authors  on Authors.AuthorID = Albums.AuthorID  JOIN Genres on Genres.GenreID = Albums.GenreID";

    query.exec(queryString);
    auto list = new QList<QVariant>();
    while (query.next()) {
        QSqlRecord record = query.record();

        auto album = new Album();
        album->setAlbumID(record.value("AlbumID").toInt());
        album->setName(record.value("Name").toString());
        album->setYear(record.value("Year").toInt());
        album->setGenreName(record.value("GenreName").toString());
        album->setAuthorName(record.value("FirstName").toString() + " " + record.value("LastName").toString());
        QVariant v = QVariant::fromValue(album);
        list->insert(list->size(),v);
    }
    return *list;
}

QVariant AlbumService::getAlbum()
{
    QSqlQuery query;
    QString queryString = "SELECT AlbumID, Name, AuthorID, Year, GenreID,  FROM Albums as al JOIN Authors au on au.AuthorID = al.AuthorID ";

    query.exec(queryString);
    auto list = new QList<QVariant>();
    while (query.next()) {
        QSqlRecord record = query.record();

        auto album = new Album();
        album->setAlbumID(record.value("AlbumID").toInt());
        album->setName(record.value("Name").toString());
        album->setYear(record.value("Year").toInt());
        QVariant v = QVariant::fromValue(album);
        return v;
    }

}

QList<QVariant> AlbumService::getSongs(int albumID)
{

    QSqlQuery query;
    QString queryString = "SELECT SongID, Name FROM SONGS WHERE AlbumID = ";
    queryString.append(QString::number(albumID));

    query.exec(queryString);
    auto list = new QList<QVariant>();
    while (query.next()) {
        QSqlRecord record = query.record();

        auto song = new Song();
        song->setName(record.value("Name").toString());

        QVariant v = QVariant::fromValue(song);
        list->insert(list->size(),v);
    }
    return *list;
}

QList<QVariant> AlbumService::getAlbums(int authorID)
{
    QSqlQuery query;
    QString queryString = "SELECT Albums.AlbumID, Albums.Name, Albums.AuthorID, Albums.Year, Albums.GenreID, Authors.FirstName, Authors.LastName,  Genres.Name as GenreName FROM Albums JOIN Authors  on Authors.AuthorID = Albums.AuthorID  JOIN Genres on Genres.GenreID = Albums.GenreID";
    queryString.append(" WHERE Albums.AuthorID = ");
    queryString.append(QString::number(authorID));
    qDebug() << queryString;
    query.exec(queryString);
    auto list = new QList<QVariant>();
    while (query.next()) {
        QSqlRecord record = query.record();

        auto album = new Album();
        album->setAlbumID(record.value("AlbumID").toInt());
        album->setName(record.value("Name").toString());
        album->setYear(record.value("Year").toInt());
        album->setGenreName(record.value("GenreName").toString());
        album->setAuthorName(record.value("FirstName").toString() + " " + record.value("LastName").toString());
        QVariant v = QVariant::fromValue(album);
        list->insert(list->size(),v);
    }
    return *list;
}
