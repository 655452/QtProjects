#ifndef WATERFALLDATAMODEL_H
#define WATERFALLDATAMODEL_H

#include <QAbstractListModel>
#include <QStringList>

class SeriesData
{
public:
    SeriesData(const QString &type, const QString &size);


    QString type() const;
    QString size() const;

private:
    QString m_type;
    QString m_size;
};

///Model class
class WaterFallDataModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum LineDataRoles {
        TypeRole = Qt:: UserRole + 1,
        SizeRole
    };

    WaterFallDataModel(QObject *parent = nullptr);

    void addAnimal(const SeriesData &seriesData);
    int rowCount(const QModelIndex &parent = QModelIndex()) const;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;

protected:
    QHash<int, QByteArray> roleNames() const;
private:
    QList<SeriesData> m_animals;
};

#endif // WATERFALLDATAMODEL_H
