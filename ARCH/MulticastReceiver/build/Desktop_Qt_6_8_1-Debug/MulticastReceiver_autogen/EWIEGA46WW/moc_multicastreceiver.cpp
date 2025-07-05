/****************************************************************************
** Meta object code from reading C++ file 'multicastreceiver.h'
**
** Created by: The Qt Meta Object Compiler version 68 (Qt 6.8.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../multicastreceiver.h"
#include <QtCore/qmetatype.h>
#include <QtCore/qplugin.h>
#include <QtCore/QList>

#include <QtCore/qtmochelpers.h>

#include <memory>


#include <QtCore/qxptype_traits.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'multicastreceiver.h' doesn't include <QObject>."
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
struct qt_meta_tag_ZN17MulticastReceiverE_t {};
} // unnamed namespace


#ifdef QT_MOC_HAS_STRINGDATA
static constexpr auto qt_meta_stringdata_ZN17MulticastReceiverE = QtMocHelpers::stringData(
    "MulticastReceiver",
    "part1DataReceived",
    "",
    "QList<int>",
    "data",
    "part2DataReceived",
    "readPendingDatagrams",
    "handleNodeTimeout",
    "nodeId",
    "part1Data",
    "part2Data"
);
#else  // !QT_MOC_HAS_STRINGDATA
#error "qtmochelpers.h not found or too old."
#endif // !QT_MOC_HAS_STRINGDATA

Q_CONSTINIT static const uint qt_meta_data_ZN17MulticastReceiverE[] = {

 // content:
      12,       // revision
       0,       // classname
       0,    0, // classinfo
       4,   14, // methods
       2,   48, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       2,       // signalCount

 // signals: name, argc, parameters, tag, flags, initial metatype offsets
       1,    1,   38,    2, 0x06,    3 /* Public */,
       5,    1,   41,    2, 0x06,    5 /* Public */,

 // slots: name, argc, parameters, tag, flags, initial metatype offsets
       6,    0,   44,    2, 0x08,    7 /* Private */,
       7,    1,   45,    2, 0x08,    8 /* Private */,

 // signals: parameters
    QMetaType::Void, 0x80000000 | 3,    4,
    QMetaType::Void, 0x80000000 | 3,    4,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int,    8,

 // properties: name, type, flags, notifyId, revision
       9, 0x80000000 | 3, 0x00015009, uint(0), 0,
      10, 0x80000000 | 3, 0x00015009, uint(1), 0,

       0        // eod
};

Q_CONSTINIT const QMetaObject MulticastReceiver::staticMetaObject = { {
    QMetaObject::SuperData::link<IMulticastReceiver::staticMetaObject>(),
    qt_meta_stringdata_ZN17MulticastReceiverE.offsetsAndSizes,
    qt_meta_data_ZN17MulticastReceiverE,
    qt_static_metacall,
    nullptr,
    qt_incomplete_metaTypeArray<qt_meta_tag_ZN17MulticastReceiverE_t,
        // property 'part1Data'
        QtPrivate::TypeAndForceComplete<QList<int>, std::true_type>,
        // property 'part2Data'
        QtPrivate::TypeAndForceComplete<QList<int>, std::true_type>,
        // Q_OBJECT / Q_GADGET
        QtPrivate::TypeAndForceComplete<MulticastReceiver, std::true_type>,
        // method 'part1DataReceived'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QList<int> &, std::false_type>,
        // method 'part2DataReceived'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QList<int> &, std::false_type>,
        // method 'readPendingDatagrams'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'handleNodeTimeout'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<int, std::false_type>
    >,
    nullptr
} };

void MulticastReceiver::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    auto *_t = static_cast<MulticastReceiver *>(_o);
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: _t->part1DataReceived((*reinterpret_cast< std::add_pointer_t<QList<int>>>(_a[1]))); break;
        case 1: _t->part2DataReceived((*reinterpret_cast< std::add_pointer_t<QList<int>>>(_a[1]))); break;
        case 2: _t->readPendingDatagrams(); break;
        case 3: _t->handleNodeTimeout((*reinterpret_cast< std::add_pointer_t<int>>(_a[1]))); break;
        default: ;
        }
    }
    if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        switch (_id) {
        default: *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType(); break;
        case 0:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType(); break;
            case 0:
                *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType::fromType< QList<int> >(); break;
            }
            break;
        case 1:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType(); break;
            case 0:
                *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType::fromType< QList<int> >(); break;
            }
            break;
        }
    }
    if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _q_method_type = void (MulticastReceiver::*)(const QList<int> & );
            if (_q_method_type _q_method = &MulticastReceiver::part1DataReceived; *reinterpret_cast<_q_method_type *>(_a[1]) == _q_method) {
                *result = 0;
                return;
            }
        }
        {
            using _q_method_type = void (MulticastReceiver::*)(const QList<int> & );
            if (_q_method_type _q_method = &MulticastReceiver::part2DataReceived; *reinterpret_cast<_q_method_type *>(_a[1]) == _q_method) {
                *result = 1;
                return;
            }
        }
    }
    if (_c == QMetaObject::RegisterPropertyMetaType) {
        switch (_id) {
        default: *reinterpret_cast<int*>(_a[0]) = -1; break;
        case 1:
        case 0:
            *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QList<int> >(); break;
        }
    }
    if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QList<int>*>(_v) = _t->part1Data(); break;
        case 1: *reinterpret_cast< QList<int>*>(_v) = _t->part2Data(); break;
        default: break;
        }
    }
}

const QMetaObject *MulticastReceiver::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *MulticastReceiver::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_ZN17MulticastReceiverE.stringdata0))
        return static_cast<void*>(this);
    if (!strcmp(_clname, "com.example.IMulticastReceiver"))
        return static_cast< IMulticastReceiver*>(this);
    return IMulticastReceiver::qt_metacast(_clname);
}

int MulticastReceiver::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = IMulticastReceiver::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 4)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 4;
    }
    if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 4)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 4;
    }
    if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::BindableProperty
            || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 2;
    }
    return _id;
}

// SIGNAL 0
void MulticastReceiver::part1DataReceived(const QList<int> & _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void MulticastReceiver::part2DataReceived(const QList<int> & _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

#ifdef QT_MOC_EXPORT_PLUGIN_V2
static constexpr unsigned char qt_pluginMetaDataV2_MulticastReceiver[] = {
    0xbf, 
    // "IID"
    0x02,  0x78,  0x1e,  'c',  'o',  'm',  '.',  'e', 
    'x',  'a',  'm',  'p',  'l',  'e',  '.',  'I', 
    'M',  'u',  'l',  't',  'i',  'c',  'a',  's', 
    't',  'R',  'e',  'c',  'e',  'i',  'v',  'e', 
    'r', 
    // "className"
    0x03,  0x71,  'M',  'u',  'l',  't',  'i',  'c', 
    'a',  's',  't',  'R',  'e',  'c',  'e',  'i', 
    'v',  'e',  'r', 
    0xff, 
};
QT_MOC_EXPORT_PLUGIN_V2(MulticastReceiver, MulticastReceiver, qt_pluginMetaDataV2_MulticastReceiver)
#else
QT_PLUGIN_METADATA_SECTION
Q_CONSTINIT static constexpr unsigned char qt_pluginMetaData_MulticastReceiver[] = {
    'Q', 'T', 'M', 'E', 'T', 'A', 'D', 'A', 'T', 'A', ' ', '!',
    // metadata version, Qt version, architectural requirements
    0, QT_VERSION_MAJOR, QT_VERSION_MINOR, qPluginArchRequirements(),
    0xbf, 
    // "IID"
    0x02,  0x78,  0x1e,  'c',  'o',  'm',  '.',  'e', 
    'x',  'a',  'm',  'p',  'l',  'e',  '.',  'I', 
    'M',  'u',  'l',  't',  'i',  'c',  'a',  's', 
    't',  'R',  'e',  'c',  'e',  'i',  'v',  'e', 
    'r', 
    // "className"
    0x03,  0x71,  'M',  'u',  'l',  't',  'i',  'c', 
    'a',  's',  't',  'R',  'e',  'c',  'e',  'i', 
    'v',  'e',  'r', 
    0xff, 
};
QT_MOC_EXPORT_PLUGIN(MulticastReceiver, MulticastReceiver)
#endif  // QT_MOC_EXPORT_PLUGIN_V2

QT_WARNING_POP
