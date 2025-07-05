/****************************************************************************
** Meta object code from reading C++ file 'TreeNavigator.h'
**
** Created by: The Qt Meta Object Compiler version 68 (Qt 6.8.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../TreeNavigator.h"
#include <QtCore/qmetatype.h>

#include <QtCore/qtmochelpers.h>

#include <memory>


#include <QtCore/qxptype_traits.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'TreeNavigator.h' doesn't include <QObject>."
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
struct qt_meta_tag_ZN13TreeNavigatorE_t {};
} // unnamed namespace


#ifdef QT_MOC_HAS_STRINGDATA
static constexpr auto qt_meta_stringdata_ZN13TreeNavigatorE = QtMocHelpers::stringData(
    "TreeNavigator",
    "currentNodeChanged",
    "",
    "traverseForward",
    "index",
    "traverseBackward",
    "setComponent",
    "component",
    "currentChildren",
    "currentAction",
    "currentKey",
    "activeKeyData",
    "QVariantMap"
);
#else  // !QT_MOC_HAS_STRINGDATA
#error "qtmochelpers.h not found or too old."
#endif // !QT_MOC_HAS_STRINGDATA

Q_CONSTINIT static const uint qt_meta_data_ZN13TreeNavigatorE[] = {

 // content:
      12,       // revision
       0,       // classname
       0,    0, // classinfo
       4,   14, // methods
       4,   46, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: name, argc, parameters, tag, flags, initial metatype offsets
       1,    0,   38,    2, 0x06,    5 /* Public */,

 // methods: name, argc, parameters, tag, flags, initial metatype offsets
       3,    1,   39,    2, 0x02,    6 /* Public */,
       5,    0,   42,    2, 0x02,    8 /* Public */,
       6,    1,   43,    2, 0x02,    9 /* Public */,

 // signals: parameters
    QMetaType::Void,

 // methods: parameters
    QMetaType::Bool, QMetaType::Int,    4,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::QString,    7,

 // properties: name, type, flags, notifyId, revision
       8, QMetaType::QStringList, 0x00015001, uint(0), 0,
       9, QMetaType::QString, 0x00015001, uint(0), 0,
      10, QMetaType::QString, 0x00015001, uint(0), 0,
      11, 0x80000000 | 12, 0x00015009, uint(0), 0,

       0        // eod
};

Q_CONSTINIT const QMetaObject TreeNavigator::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_ZN13TreeNavigatorE.offsetsAndSizes,
    qt_meta_data_ZN13TreeNavigatorE,
    qt_static_metacall,
    nullptr,
    qt_incomplete_metaTypeArray<qt_meta_tag_ZN13TreeNavigatorE_t,
        // property 'currentChildren'
        QtPrivate::TypeAndForceComplete<QStringList, std::true_type>,
        // property 'currentAction'
        QtPrivate::TypeAndForceComplete<QString, std::true_type>,
        // property 'currentKey'
        QtPrivate::TypeAndForceComplete<QString, std::true_type>,
        // property 'activeKeyData'
        QtPrivate::TypeAndForceComplete<QVariantMap, std::true_type>,
        // Q_OBJECT / Q_GADGET
        QtPrivate::TypeAndForceComplete<TreeNavigator, std::true_type>,
        // method 'currentNodeChanged'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'traverseForward'
        QtPrivate::TypeAndForceComplete<bool, std::false_type>,
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        // method 'traverseBackward'
        QtPrivate::TypeAndForceComplete<bool, std::false_type>,
        // method 'setComponent'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>
    >,
    nullptr
} };

void TreeNavigator::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    auto *_t = static_cast<TreeNavigator *>(_o);
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: _t->currentNodeChanged(); break;
        case 1: { bool _r = _t->traverseForward((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 2: { bool _r = _t->traverseBackward();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 3: _t->setComponent((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        default: ;
        }
    }
    if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _q_method_type = void (TreeNavigator::*)();
            if (_q_method_type _q_method = &TreeNavigator::currentNodeChanged; *reinterpret_cast<_q_method_type *>(_a[1]) == _q_method) {
                *result = 0;
                return;
            }
        }
    }
    if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QStringList*>(_v) = _t->currentChildren(); break;
        case 1: *reinterpret_cast< QString*>(_v) = _t->currentAction(); break;
        case 2: *reinterpret_cast< QString*>(_v) = _t->currentKey(); break;
        case 3: *reinterpret_cast< QVariantMap*>(_v) = _t->activeKeyData(); break;
        default: break;
        }
    }
}

const QMetaObject *TreeNavigator::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *TreeNavigator::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_ZN13TreeNavigatorE.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int TreeNavigator::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 4)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 4;
    }
    if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 4)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 4;
    }
    if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::BindableProperty
            || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 4;
    }
    return _id;
}

// SIGNAL 0
void TreeNavigator::currentNodeChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}
QT_WARNING_POP
