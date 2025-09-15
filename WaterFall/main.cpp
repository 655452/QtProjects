// #include <QGuiApplication>
// #include <QQmlApplicationEngine>

#include <QApplication>
#include <QDir>
#include <QQmlEngine>
#include <QQuickView>

// waterfall model include
#include <WaterFallDataModel.h>
#include <ChartManager.h>

int main(int argc, char *argv[])
{
    // Register ChartManager to be used in QML
    qmlRegisterType<ChartManager>("com.example.ChartManager", 1, 0, "ChartManager");

    QApplication app(argc, argv);

    QQuickView viewer;
    viewer.setMinimumSize({600, 400});

#ifdef Q_OS_WIN
    QString extraImportPath(QStringLiteral("%1/../../../../%2"));
#else
    QString extraImportPath(QStringLiteral("%1/../../../%2"));
#endif
    viewer.engine()->addImportPath(extraImportPath.arg(QGuiApplication::applicationDirPath(),
                                                       QString::fromLatin1("qml")));
    QObject::connect(viewer.engine(), &QQmlEngine::quit, &viewer, &QWindow::close);


    viewer.setTitle(QStringLiteral("Qt Charts QML"));
    viewer.setSource(QUrl("qrc:/qml/Main.qml"));
    viewer.setResizeMode(QQuickView::SizeRootObjectToView);
    viewer.show();


    return app.exec();
}
