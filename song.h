#ifndef SONG_H
#define SONG_H

#include <QObject>
#include <QString>

class Song : public QObject
{
    Q_OBJECT
    QString m_name;

public:
    explicit Song(QObject *parent = nullptr);
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)

QString name() const
{
    return m_name;
}

signals:

void nameChanged(QString name);

public slots:
void setName(QString name)
{
    if (m_name == name)
        return;

    m_name = name;
    emit nameChanged(m_name);
}
};

#endif // SONG_H
