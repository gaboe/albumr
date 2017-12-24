#include "authorservice.h"
#include "dbmanager.h"
#include <QVariantMap>
AuthorService::AuthorService()
{

}

int AuthorService::getAuthors()
{
    auto db= new DbManager();
    db->open();
    QSqlQuery query;
    QString queryString = "SELECT FirstName FROM Authors";

    query.exec(queryString);
    auto list = new QList<QVariant>();
    while (query.next()) {
        QSqlRecord record = query.record();
        qDebug() << "Date : " << record.value("FirstName").toString();
    }
}
