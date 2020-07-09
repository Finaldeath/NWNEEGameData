#include "ddf_journal"
#include "x0_i0_partywide"

void main()
{
    SpeakString("NW_I_AM_DEAD", TALKVOLUME_SILENT_SHOUT);

    // Shift alignment towards evil
    object oPC = GetFirstPC();

    AdjustAlignmentOnAll(oPC, ALIGNMENT_EVIL, ALIGNMENT_SLIP);

    // Set the flag that teddy is dead
    SetLocalInt(GetModule(), "ddf_teddy_dead", TRUE);

    UpdateJournal(GetFirstPC());

    if(GetLocalInt(GetModule(), "ddf_background_flag") == BG_COP)
    {
        // remove hostility from teddys faction "commoner"
        if(GetIsObjectValid(OBJECT_SELF) == FALSE)
        {
            debug("-- Teddy object is no longer valid...");
        }

        AssignCommand(oPC, ClearAllActions(TRUE));

        ClearPersonalReputationWithFaction(oPC, OBJECT_SELF);
        AdjustReputationWithFaction(oPC, OBJECT_SELF, 100);

        object oGuard = GetObjectByTag("CityGuard");
        if(oGuard == OBJECT_INVALID)
        {
            debug("-- unable to find CityGuard...");
        }

        ClearPersonalReputationWithFaction(oPC, oGuard);
        AdjustReputationWithFaction(oPC, oGuard, 100);
    }


}
