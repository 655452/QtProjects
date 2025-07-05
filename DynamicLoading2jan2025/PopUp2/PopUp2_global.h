#ifndef POPUP2_GLOBAL_H
#define POPUP2_GLOBAL_H

#include <QtCore/qglobal.h>

#if defined(POPUP2_LIBRARY)
#define POPUP2_EXPORT Q_DECL_EXPORT
#else
#define POPUP2_EXPORT Q_DECL_IMPORT
#endif

#endif // POPUP2_GLOBAL_H
