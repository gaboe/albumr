#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QtSql>
#include <QStandardPaths>
#include "dbmanager.h"
#include "authorservice.h"
#include "albumservice.h"


    class MyClass {
    public:
        MyClass() : value(0) { }
        MyClass(int value) : value(value) { }
        MyClass(const MyClass &other) { value = other.value; }
        ~MyClass() { }
        int getValue() const { return value; }
    private:
        int value;
    };


Q_DECLARE_METATYPE(MyClass);



int main(int argc, char *argv[])
{
#if defined(Q_OS_WIN)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    MyClass m(15);
        QVariant v = QVariant::fromValue(m);
        qDebug() << v.canConvert<MyClass>();
        qDebug() << v.value<MyClass>().getValue();

    QGuiApplication app(argc, argv);

    auto dbManager = new DbManager();
    auto isDbOpened = dbManager->open();
    if(!isDbOpened)
        return 1;

    auto authorService = new AuthorService();
    auto albumService = new AlbumService();

    //QObject::connect(&albumService,&AlbumService::albumDetailChanged,&albumService,&AlbumService::setSongs);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    engine.rootContext()->setContextProperty("applicationPath", "file://"+qApp->applicationDirPath()+ "/../albumr/images");
    engine.rootContext()->setContextProperty("authorService", authorService);
    engine.rootContext()->setContextProperty("albumService", albumService);

    qmlRegisterType<Author>();

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
