/****************************************************************************
** Resource object code
**
** Created by: The Resource Compiler for Qt version 6.8.1
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#ifdef _MSC_VER
// disable informational message "function ... selected for automatic inline expansion"
#pragma warning (disable: 4711)
#endif

static const unsigned char qt_resource_data[] = {
  // node_config.xml
  0x0,0x0,0x0,0x45,
  0x3c,
  0x6e,0x6f,0x64,0x65,0x3e,0xa,0x20,0x20,0x20,0x20,0x3c,0x69,0x64,0x3e,0x34,0x3c,
  0x2f,0x69,0x64,0x3e,0xa,0x20,0x20,0x20,0x20,0x3c,0x73,0x74,0x61,0x74,0x75,0x73,
  0x3e,0x31,0x2c,0x30,0x2c,0x31,0x2c,0x31,0x2c,0x30,0x2c,0x31,0x2c,0x31,0x2c,0x31,
  0x2c,0x30,0x3c,0x2f,0x73,0x74,0x61,0x74,0x75,0x73,0x3e,0xa,0x3c,0x2f,0x6e,0x6f,
  0x64,0x65,0x3e,0xa,
  
};

static const unsigned char qt_resource_name[] = {
  // node_config.xml
  0x0,0xf,
  0x9,0x95,0x7e,0xdc,
  0x0,0x6e,
  0x0,0x6f,0x0,0x64,0x0,0x65,0x0,0x5f,0x0,0x63,0x0,0x6f,0x0,0x6e,0x0,0x66,0x0,0x69,0x0,0x67,0x0,0x2e,0x0,0x78,0x0,0x6d,0x0,0x6c,
  
};

static const unsigned char qt_resource_struct[] = {
  // :
  0x0,0x0,0x0,0x0,0x0,0x2,0x0,0x0,0x0,0x1,0x0,0x0,0x0,0x1,
0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
  // :/node_config.xml
  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x1,0x0,0x0,0x0,0x0,
0x0,0x0,0x1,0x94,0xfa,0xf7,0x5d,0xcd,

};

#ifdef QT_NAMESPACE
#  define QT_RCC_PREPEND_NAMESPACE(name) ::QT_NAMESPACE::name
#  define QT_RCC_MANGLE_NAMESPACE0(x) x
#  define QT_RCC_MANGLE_NAMESPACE1(a, b) a##_##b
#  define QT_RCC_MANGLE_NAMESPACE2(a, b) QT_RCC_MANGLE_NAMESPACE1(a,b)
#  define QT_RCC_MANGLE_NAMESPACE(name) QT_RCC_MANGLE_NAMESPACE2( \
        QT_RCC_MANGLE_NAMESPACE0(name), QT_RCC_MANGLE_NAMESPACE0(QT_NAMESPACE))
#else
#   define QT_RCC_PREPEND_NAMESPACE(name) name
#   define QT_RCC_MANGLE_NAMESPACE(name) name
#endif

#if defined(QT_INLINE_NAMESPACE)
inline namespace QT_NAMESPACE {
#elif defined(QT_NAMESPACE)
namespace QT_NAMESPACE {
#endif

bool qRegisterResourceData(int, const unsigned char *, const unsigned char *, const unsigned char *);
bool qUnregisterResourceData(int, const unsigned char *, const unsigned char *, const unsigned char *);

#ifdef QT_NAMESPACE
}
#endif

int QT_RCC_MANGLE_NAMESPACE(qInitResources_res)();
int QT_RCC_MANGLE_NAMESPACE(qInitResources_res)()
{
    int version = 3;
    QT_RCC_PREPEND_NAMESPACE(qRegisterResourceData)
        (version, qt_resource_struct, qt_resource_name, qt_resource_data);
    return 1;
}

int QT_RCC_MANGLE_NAMESPACE(qCleanupResources_res)();
int QT_RCC_MANGLE_NAMESPACE(qCleanupResources_res)()
{
    int version = 3;
    QT_RCC_PREPEND_NAMESPACE(qUnregisterResourceData)
       (version, qt_resource_struct, qt_resource_name, qt_resource_data);
    return 1;
}

#ifdef __clang__
#   pragma clang diagnostic push
#   pragma clang diagnostic ignored "-Wexit-time-destructors"
#endif

namespace {
   struct initializer {
       initializer() { QT_RCC_MANGLE_NAMESPACE(qInitResources_res)(); }
       ~initializer() { QT_RCC_MANGLE_NAMESPACE(qCleanupResources_res)(); }
   } dummy;
}

#ifdef __clang__
#   pragma clang diagnostic pop
#endif
