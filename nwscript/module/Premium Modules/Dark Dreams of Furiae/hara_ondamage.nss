#include "ddf_util"
#include "x0_i0_partywide"

void main()
{
    object oPC = GetLastDamager();
    int iHP = GetCurrentHitPoints();


    // Check if we only have one hitpoint left
    if (iHP == 1)
    {
        // stop all mercs too.
        int iCounter = 0;
        object oNPC = GetObjectByTag("MercenarySTI", iCounter);
        while(GetIsObjectValid(oNPC))
        {
            AssignCommand(oNPC, SurrenderToEnemies());
            AssignCommand(oNPC, ClearAllActions(TRUE));
            iCounter = iCounter + 1;
            oNPC = GetObjectByTag("MercenarySTI", iCounter);
        }
        //BeginConversation("hara_001", oPC);

        SetLocalInt(GetModule(), "ddf_harasi_surrendered", TRUE);
        SurrenderAllToEnemies(OBJECT_SELF);


        //ClearAllActions(TRUE);
        DelayCommand(1.0, ActionStartConversation(oPC, "hara_001", FALSE, FALSE));
        //BeginConversation("hara_001", oPC);

    }
}
