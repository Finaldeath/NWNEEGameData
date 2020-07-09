////////////////////////////////////////////////////////////////////////////////
// dla_scsellh3 - script created to prevent exploits in selling horses
// Scripted By: Deva B. Winblood   8/05/2006
////////////////////////////////////////////////////////////////////////////////
#include "dla_i0_horse"


int StartingConditional()
{
    object oHorse=GetLocalObject(OBJECT_SELF,"oInterested");
    object oMaster;
    if (!GetIsObjectValid(oHorse)) return TRUE;
    oMaster=GetLocalObject(oHorse,"oDLAMyMaster");
    if (GetIsObjectValid(oMaster)&&DLA_GetIsMounted(oMaster)) return TRUE;
    if (GetArea(oHorse)!=GetArea(OBJECT_SELF)) return TRUE;
    return FALSE;
}
