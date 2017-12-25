#ifndef ALBUMSERVICE_H
#define ALBUMSERVICE_H

#include <QObject>
#include <QVariant>

class AlbumService : public QObject
{
    Q_OBJECT
    QVariant m_albumDetail;

public:
    explicit AlbumService(QObject *parent = nullptr);
    Q_INVOKABLE QList<QVariant> getAlbums();
    Q_INVOKABLE QVariant getAlbum();
Q_PROPERTY(QVariant albumDetail READ albumDetail WRITE setAlbumDetail NOTIFY albumDetailChanged)
QVariant albumDetail() const
{
    return m_albumDetail;
}

signals:

void albumDetailChanged(QVariant albumDetail);

public slots:
void setAlbumDetail(QVariant albumDetail)
{
    if (m_albumDetail == albumDetail)
        return;

    m_albumDetail = albumDetail;
    emit albumDetailChanged(m_albumDetail);
}
};

#endif // ALBUMSERVICE_H
