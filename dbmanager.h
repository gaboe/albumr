#ifndef DBMANAGER_H
#define DBMANAGER_H

#include <QObject>
#include <QtSql>

class DbManager
{
public:
    DbManager();
    void open();

private:
    void init(QSqlDatabase db);
    QString getInitScriptForAuthors();
    QString getInitScriptForGenres();
    QString getInitScriptForAlbums();
    QString getInitScriptForSongs();

};

#endif // DBMANAGER_H
