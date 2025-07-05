#ifndef POPUP4_GLOBAL_H
#define POPUP4_GLOBAL_H

#include <QtCore/qglobal.h>

#if defined(POPUP4_LIBRARY)
#define POPUP4_EXPORT Q_DECL_EXPORT
#else
#define POPUP4_EXPORT Q_DECL_IMPORT
#endif

#endif // POPUP4_GLOBAL_H
