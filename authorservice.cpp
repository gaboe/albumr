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
    QSqlQuery query;
    QString queryString = "SELECT AuthorID, FirstName, LastName FROM Authors";

    query.exec(queryString);
    auto list = new QList<QVariant>();
    while (query.next()) {
        QSqlRecord record = query.record();

        auto author = new Author();
        author->setFirstName(record.value("FirstName").toString());
        author->setLastName(record.value("LastName").toString());
        author->setAuthorID(record.value("AuthorID").toInt());
        qDebug() << author->authorID();
        QVariant v = QVariant::fromValue(author);
        list->insert(list->size(),v);
    }
    return *list;
}

QVariant AuthorService::getAuthor(int authorID)
{
    QSqlQuery query;
    QString queryString = "SELECT AuthorID, FirstName, LastName FROM Authors";
    queryString.append(" WHERE AuthorID = ");
    queryString.append(QString::number(authorID));
    qDebug() << queryString;
    query.exec(queryString);
    while (query.next()) {
        QSqlRecord record = query.record();

        auto author = new Author();
        author->setFirstName(record.value("FirstName").toString());
        author->setLastName(record.value("LastName").toString());
        author->setAuthorID(record.value("AuthorID").toInt());
        QVariant v = QVariant::fromValue(author);
        return v;
    }
}
