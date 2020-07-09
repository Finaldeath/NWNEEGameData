// sidequest: pirates of the moonsea
// player has defeated the pirates and is able to leave the area

#include "hf_in_npc"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if (GetTag(GetArea(oPC)) == "area094")
    {
        object oEnemy = GetNearestEnemy(oPC);
        if (!GetIsObjectValid(oEnemy))
        {
            return TRUE;
        }
    }
    return FALSE;
}
