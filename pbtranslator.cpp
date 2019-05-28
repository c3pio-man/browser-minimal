#include "pbtranslator.h"
#include "inkview.h"

using namespace pocketbook::utils;

PBTranslator::PBTranslator()
{

}

QString PBTranslator::translate(const char *context, const char *sourceText,
                          const char *disambiguation, int n) const
{
    Q_UNUSED(context);
    Q_UNUSED(disambiguation);
    Q_UNUSED(n);
    return QString::fromUtf8(GetLangText(sourceText));
}
