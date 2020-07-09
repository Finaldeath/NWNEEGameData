#include "ddf_util"
#include "x0_i0_partywide"

void main()
{
    object oPC = GetLastDamager();
    int iHP = GetCurrentHitPoints();

    // Check if we only have one hitpoint left
    if (iHP == 1)
    {
        SurrenderAllToEnemies(OBJECT_SELF);
        BeginConversation("ulan_002", oPC);
    }
}
