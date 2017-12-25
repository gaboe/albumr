#ifndef AUTHORSERVICE_H
#define AUTHORSERVICE_H
#include <QQmlListProperty>
#include <author.h>
#include <QObject>

class AuthorService : public QObject
{
    Q_OBJECT
public:
    explicit AuthorService(QObject *parent = nullptr);
    Q_INVOKABLE QList<QVariant> getAuthors();
};

#endif // AUTHORSERVICE_H
