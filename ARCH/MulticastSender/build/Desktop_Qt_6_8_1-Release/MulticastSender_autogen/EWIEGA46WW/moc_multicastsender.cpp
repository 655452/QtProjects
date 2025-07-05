/****************************************************************************
** Meta object code from reading C++ file 'multicastsender.h'
**
** Created by: The Qt Meta Object Compiler version 68 (Qt 6.8.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../multicastsender.h"
#include <QtCore/qmetatype.h>
#include <QtCore/qplugin.h>

#include <QtCore/qtmochelpers.h>

#include <memory>


#include <QtCore/qxptype_traits.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'multicastsender.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 68
#error "This file was generated using the moc from 6.8.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

#ifndef Q_CONSTINIT
#define Q_CONSTINIT
#endif

QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
QT_WARNING_DISABLE_GCC("-Wuseless-cast")
namespace {
struct qt_meta_tag_ZN21MulticastSenderWorkerE_t {};
} // unnamed namespace


#ifdef QT_MOC_HAS_STRINGDATA
static constexpr auto qt_meta_stringdata_ZN21MulticastSenderWorkerE = QtMocHelpers::stringData(
    "MulticastSenderWorker",
    "startBroadcasting",
    "",
    "stopBroadcasting",
    "sendMulticastMessage"
);
#else  // !QT_MOC_HAS_STRINGDATA
#error "qtmochelpers.h not found or too old."
#endif // !QT_MOC_HAS_STRINGDATA

Q_CONSTINIT static const uint qt_meta_data_ZN21MulticastSenderWorkerE[] = {

 // content:
      12,       // revision
       0,       // classname
       0,    0, // classinfo
       3,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: name, argc, parameters, tag, flags, initial metatype offsets
       1,    0,   32,    2, 0x0a,    1 /* Public */,
       3,    0,   33,    2, 0x0a,    2 /* Public */,
       4,    0,   34,    2, 0x0a,    3 /* Public */,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

       0        // eod
};

Q_CONSTINIT const QMetaObject MulticastSenderWorker::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_ZN21MulticastSenderWorkerE.offsetsAndSizes,
    qt_meta_data_ZN21MulticastSenderWorkerE,
    qt_static_metacall,
    nullptr,
    qt_incomplete_metaTypeArray<qt_meta_tag_ZN21MulticastSenderWorkerE_t,
        // Q_OBJECT / Q_GADGET
        QtPrivate::TypeAndForceComplete<MulticastSenderWorker, std::true_type>,
        // method 'startBroadcasting'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'stopBroadcasting'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'sendMulticastMessage'
        QtPrivate::TypeAndForceComplete<void, std::false_type>
    >,
    nullptr
} };

void MulticastSenderWorker::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    auto *_t = static_cast<MulticastSenderWorker *>(_o);
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: _t->startBroadcasting(); break;
        case 1: _t->stopBroadcasting(); break;
        case 2: _t->sendMulticastMessage(); break;
        default: ;
        }
    }
    (void)_a;
}

const QMetaObject *MulticastSenderWorker::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *MulticastSenderWorker::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_ZN21MulticastSenderWorkerE.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int MulticastSenderWorker::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 3)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 3;
    }
    if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 3)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 3;
    }
    return _id;
}
namespace {
struct qt_meta_tag_ZN15MulticastSenderE_t {};
} // unnamed namespace


#ifdef QT_MOC_HAS_STRINGDATA
static constexpr auto qt_meta_stringdata_ZN15MulticastSenderE = QtMocHelpers::stringData(
    "MulticastSender"
);
#else  // !QT_MOC_HAS_STRINGDATA
#error "qtmochelpers.h not found or too old."
#endif // !QT_MOC_HAS_STRINGDATA

Q_CONSTINIT static const uint qt_meta_data_ZN15MulticastSenderE[] = {

 // content:
      12,       // revision
       0,       // classname
       0,    0, // classinfo
       0,    0, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

       0        // eod
};

Q_CONSTINIT const QMetaObject MulticastSender::staticMetaObject = { {
    QMetaObject::SuperData::link<IMulticastSender::staticMetaObject>(),
    qt_meta_stringdata_ZN15MulticastSenderE.offsetsAndSizes,
    qt_meta_data_ZN15MulticastSenderE,
    qt_static_metacall,
    nullptr,
    qt_incomplete_metaTypeArray<qt_meta_tag_ZN15MulticastSenderE_t,
        // Q_OBJECT / Q_GADGET
        QtPrivate::TypeAndForceComplete<MulticastSender, std::true_type>
    >,
    nullptr
} };

void MulticastSender::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    auto *_t = static_cast<MulticastSender *>(_o);
    (void)_t;
    (void)_c;
    (void)_id;
    (void)_a;
}

const QMetaObject *MulticastSender::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *MulticastSender::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_ZN15MulticastSenderE.stringdata0))
        return static_cast<void*>(this);
    if (!strcmp(_clname, "com.example.IMulticastSender"))
        return static_cast< IMulticastSender*>(this);
    return IMulticastSender::qt_metacast(_clname);
}

int MulticastSender::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = IMulticastSender::qt_metacall(_c, _id, _a);
    return _id;
}

#ifdef QT_MOC_EXPORT_PLUGIN_V2
static constexpr unsigned char qt_pluginMetaDataV2_MulticastSender[] = {
    0xbf, 
    // "IID"
    0x02,  0x78,  0x1c,  'c',  'o',  'm',  '.',  'e', 
    'x',  'a',  'm',  'p',  'l',  'e',  '.',  'I', 
    'M',  'u',  'l',  't',  'i',  'c',  'a',  's', 
    't',  'S',  'e',  'n',  'd',  'e',  'r', 
    // "className"
    0x03,  0x6f,  'M',  'u',  'l',  't',  'i',  'c', 
    'a',  's',  't',  'S',  'e',  'n',  'd',  'e', 
    'r', 
    0xff, 
};
QT_MOC_EXPORT_PLUGIN_V2(MulticastSender, MulticastSender, qt_pluginMetaDataV2_MulticastSender)
#else
QT_PLUGIN_METADATA_SECTION
Q_CONSTINIT static constexpr unsigned char qt_pluginMetaData_MulticastSender[] = {
    'Q', 'T', 'M', 'E', 'T', 'A', 'D', 'A', 'T', 'A', ' ', '!',
    // metadata version, Qt version, architectural requirements
    0, QT_VERSION_MAJOR, QT_VERSION_MINOR, qPluginArchRequirements(),
    0xbf, 
    // "IID"
    0x02,  0x78,  0x1c,  'c',  'o',  'm',  '.',  'e', 
    'x',  'a',  'm',  'p',  'l',  'e',  '.',  'I', 
    'M',  'u',  'l',  't',  'i',  'c',  'a',  's', 
    't',  'S',  'e',  'n',  'd',  'e',  'r', 
    // "className"
    0x03,  0x6f,  'M',  'u',  'l',  't',  'i',  'c', 
    'a',  's',  't',  'S',  'e',  'n',  'd',  'e', 
    'r', 
    0xff, 
};
QT_MOC_EXPORT_PLUGIN(MulticastSender, MulticastSender)
#endif  // QT_MOC_EXPORT_PLUGIN_V2

QT_WARNING_POP
