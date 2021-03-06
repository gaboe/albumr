#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QtSql>
#include <QStandardPaths>
#include "dbmanager.h"
#include "authormodel.h"
#include "albummodel.h"
#include <QFileInfo>

int main(int argc, char *argv[])
{
    #define CACHE_EXPIRE_TIME 0
#if defined(Q_OS_WIN)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    auto dbManager = new DbManager();
    auto isDbOpened = dbManager->open();
    if(!isDbOpened)
        return 1;

    auto authorModel = new AuthorModel();
    auto albumModel = new AlbumModel();

    authorModel->refreshGenres();
    albumModel->setApplicationPath(qApp->applicationDirPath()+ "/../albumr/images");
    albumModel->setImagePath("file://"+qApp->applicationDirPath()+ "/../albumr/images");

    albumModel->refreshAlbums();

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    engine.rootContext()->setContextProperty("applicationPath", "file://"+qApp->applicationDirPath()+ "/../albumr/images");
    engine.rootContext()->setContextProperty("authorModel", authorModel);
    engine.rootContext()->setContextProperty("albumModel", albumModel);

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
