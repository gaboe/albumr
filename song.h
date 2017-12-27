#ifndef SONG_H
#define SONG_H

#include <QObject>
#include <QString>

class Song : public QObject
{
    Q_OBJECT
    QString m_name;

    int m_songID;

public:
    explicit Song(QObject *parent = nullptr);
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(int songID READ songID WRITE setSongID NOTIFY songIDChanged)

QString name() const
{
    return m_name;
}

int songID() const
{
    return m_songID;
}

signals:

void nameChanged(QString name);

void songIDChanged(int songID);

public slots:
void setName(QString name)
{
    if (m_name == name)
        return;

    m_name = name;
    emit nameChanged(m_name);
}
void setSongID(int songID)
{
    if (m_songID == songID)
        return;

    m_songID = songID;
    emit songIDChanged(m_songID);
}
};

#endif // SONG_H
