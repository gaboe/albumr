#include "authorservice.h"
#include "dbmanager.h"
#include <QVariantMap>
#include "author.h"

AuthorService::AuthorService()
{

}

QList<Author*> AuthorService::getAuthors()
{
    auto db= new DbManager();
    db->open();
    QSqlQuery query;
    QString queryString = "SELECT FirstName FROM Authors";

    query.exec(queryString);
    auto list = new QList<Author*>();
    while (query.next()) {
        QSqlRecord record = query.record();
        auto author = new Author();
        author->setFirstName(record.value("FirstName").toString());
        list->append(author);
    }
    return *list;
}
