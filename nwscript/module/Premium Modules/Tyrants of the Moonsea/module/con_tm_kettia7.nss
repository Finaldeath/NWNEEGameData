// sidequest: pirates of the moonsea
// returns true when the player is still fighting the pirates

#include "hf_in_npc"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if (GetTag(GetArea(oPC)) == "area094")
    {
        object oEnemy = GetNearestEnemy(oPC);
        if (GetIsObjectValid(oEnemy))
        {
            return TRUE;
        }
    }
    return FALSE;
}
