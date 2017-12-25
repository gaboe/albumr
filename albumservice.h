#ifndef ALBUMSERVICE_H
#define ALBUMSERVICE_H

#include <QObject>
#include <QVariant>
#include <QDebug>
#include "album.h"

class AlbumService : public QObject
{
    Q_OBJECT
    QVariant m_albumDetail;

    QList<QVariant> m_songs;

public:
    explicit AlbumService(QObject *parent = nullptr);
    Q_INVOKABLE QList<QVariant> getAlbums();
    Q_INVOKABLE QVariant getAlbum();
    Q_INVOKABLE QList<QVariant> getSongs(int albumID);

    Q_PROPERTY(QVariant albumDetail READ albumDetail WRITE setAlbumDetail NOTIFY albumDetailChanged)
    Q_PROPERTY(QList<QVariant> songs READ songs WRITE setSongs NOTIFY songsChanged)
QVariant albumDetail() const
{
    return m_albumDetail;
}

QList<QVariant> songs() const
{
    return m_songs;
}

signals:

void albumDetailChanged(QVariant albumDetail);

void songsChanged(QList<QVariant> songs);

public slots:
void setNewSongs(int albumID){
    auto songs = getSongs(albumID);
    setSongs(songs);
}

void setAlbumDetail(QVariant albumDetail)
{
    if (m_albumDetail == albumDetail)
        return;

    m_albumDetail = albumDetail;
    emit albumDetailChanged(m_albumDetail);
}
void setSongs(QList<QVariant> songs)
{
    if (m_songs == songs)
        return;

    m_songs = songs;
    emit songsChanged(m_songs);
}
};

#endif // ALBUMSERVICE_H
