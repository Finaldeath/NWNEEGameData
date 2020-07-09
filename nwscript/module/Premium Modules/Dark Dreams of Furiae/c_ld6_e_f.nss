// (if you have killed Aladara)

#include "ddf_util"

int StartingConditional()
{
    object oModule = GetModule();

    if(GetLocalInt(oModule, "ddf_aladara_dead") == FALSE) return FALSE;

    return TRUE;
}
