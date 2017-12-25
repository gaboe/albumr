#include "authorservice.h"
#include "dbmanager.h"
#include <QQmlListProperty>
#include "author.h"
#include <QObject>
#include "authorservice.h"

AuthorService::AuthorService(QObject *parent) : QObject(parent)
{
}

QList<QVariant> AuthorService::getAuthors()
{
    auto db= new DbManager();
    db->open();
    QSqlQuery query;
    QString queryString = "SELECT FirstName FROM Authors";

    query.exec(queryString);
    auto list = new QList<QVariant>();
    while (query.next()) {
        QSqlRecord record = query.record();
        auto author = new Author();

        author->setFirstName(record.value("FirstName").toString());
        QVariant v = QVariant::fromValue(author);
        list->insert(list->size(),v);
    }
    return *list;
}
