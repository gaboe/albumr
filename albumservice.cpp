#include "albumservice.h"
#include "album.h"
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
    QString queryString = "SELECT AlbumID, Name, AuthorID, Year, GenreID FROM Albums";

    query.exec(queryString);
    auto list = new QList<QVariant>();
    while (query.next()) {
        QSqlRecord record = query.record();

        auto album = new Album();
        album->setAlbumID(record.value("AlbumID").toInt());
        album->setName(record.value("Name").toString());
        album->setYear(record.value("Year").toInt());
        QVariant v = QVariant::fromValue(album);
        list->insert(list->size(),v);
    }
    return *list;
}
