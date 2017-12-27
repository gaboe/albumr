#include "authormodel.h"
#include "dbmanager.h"
#include <QQmlListProperty>
#include "author.h"
#include <QObject>
#include "authormodel.h"
#include "genre.h"

AuthorModel::AuthorModel(QObject *parent) : QObject(parent)
{
}

QList<QString> AuthorModel::getGenres()
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

QList<QVariant> AuthorModel::getNewAuthors()
{
    QSqlQuery query;
    QString queryString = "SELECT AuthorID, Name FROM Authors";

    query.exec(queryString);
    auto list = new QList<QVariant>();
    while (query.next()) {
        QSqlRecord record = query.record();

        auto author = new Author();
        author->setName(record.value("Name").toString());
        author->setAuthorID(record.value("AuthorID").toInt());
        QVariant v = QVariant::fromValue(author);
        list->insert(list->size(),v);
    }
    return *list;
}

QVariant AuthorModel::getAuthor(int authorID)
{
    QSqlQuery query;
    QString queryString = "SELECT AuthorID, Name FROM Authors";
    queryString.append(" WHERE AuthorID = ");
    queryString.append(QString::number(authorID));
    query.exec(queryString);
    while (query.next()) {
        QSqlRecord record = query.record();

        auto author = new Author();
        author->setName(record.value("Name").toString());
        author->setAuthorID(record.value("AuthorID").toInt());
        QVariant v = QVariant::fromValue(author);
        return v;
    }
}

void AuthorModel::addAuthor(QString name)
{
    QSqlQuery query;
    query.prepare("INSERT INTO Authors(Name) values (:name)");
    query.bindValue(":name",name);
    query.exec();
}

void AuthorModel::updateAuthorName(QString name, int authorID)
{
    QSqlQuery query;
    query.prepare("UPDATE Authors SET name = :name WHERE Authors.AuthorID = :authorID");
    query.bindValue(":name",name);
    query.bindValue(":authorID",authorID);
    query.exec();
}

void AuthorModel::deleteAuthor(int authorID)
{
    QSqlQuery query;
    query.prepare("DELETE FROM Authors WHERE Authors.AuthorID = :authorID");
    query.bindValue(":authorID",authorID);
    query.exec();
}
