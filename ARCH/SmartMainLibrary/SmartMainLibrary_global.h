#ifndef SMARTMAINLIBRARY_GLOBAL_H
#define SMARTMAINLIBRARY_GLOBAL_H

#include <QtCore/qglobal.h>

#if defined(SMARTMAINLIBRARY_LIBRARY)
#define SMARTMAINLIBRARY_EXPORT Q_DECL_EXPORT
#else
#define SMARTMAINLIBRARY_EXPORT Q_DECL_IMPORT
#endif

#endif // SMARTMAINLIBRARY_GLOBAL_H
