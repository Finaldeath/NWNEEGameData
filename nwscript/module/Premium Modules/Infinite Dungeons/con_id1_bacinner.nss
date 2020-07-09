#include "inc_id_liltimmy"

int StartingConditional()
{
    // if masterius is the third boss
    if (lt_GetThirdLieutenant() == ID_LOCAL_LIEUTENANT_WEREBOAR)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
