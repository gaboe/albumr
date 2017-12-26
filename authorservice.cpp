#include "authorservice.h"
#include "dbmanager.h"
#include <QQmlListProperty>
#include "author.h"
#include <QObject>
#include "authorservice.h"
#include "genre.h"

AuthorService::AuthorService(QObject *parent) : QObject(parent)
{
}

QList<QString> AuthorService::getGenres()
{
    QSqlQuery query;
    QString queryString = "SELECT GenreID, Name FROM Genres";

    query.exec(queryString);
    auto list = new QList<QString>();
    while (query.next()) {
        QSqlRecord record = query.record();
        list->insert(list->size(),record.value("Name").toString());
    }
    return *list;
}

QList<QVariant> AuthorService::getNewAuthors()
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

void AuthorService::addAuthor(QString firstName,QString lastName)
{
    QSqlQuery query;
    query.prepare("INSERT INTO Authors(FirstName,LastName) values (:firstName,:lastName)");
    query.bindValue(":firstName",firstName);
    query.bindValue(":lastName", lastName);
    query.exec();
}
