#ifndef POPUP_GLOBAL_H
#define POPUP_GLOBAL_H

#include <QtCore/qglobal.h>

#if defined(POPUP_LIBRARY)
#define POPUP_EXPORT Q_DECL_EXPORT
#else
#define POPUP_EXPORT Q_DECL_IMPORT
#endif

#endif // POPUP_GLOBAL_H
