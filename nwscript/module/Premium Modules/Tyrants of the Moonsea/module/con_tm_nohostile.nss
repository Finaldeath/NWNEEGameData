#include "NW_I0_GENERIC"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oEnemy = GetNearestEnemy(oPC);

    if(oEnemy == OBJECT_INVALID)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
