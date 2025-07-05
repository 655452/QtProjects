#ifndef POPUP3_GLOBAL_H
#define POPUP3_GLOBAL_H

#include <QtCore/qglobal.h>

#if defined(POPUP3_LIBRARY)
#define POPUP3_EXPORT Q_DECL_EXPORT
#else
#define POPUP3_EXPORT Q_DECL_IMPORT
#endif

#endif // POPUP3_GLOBAL_H
