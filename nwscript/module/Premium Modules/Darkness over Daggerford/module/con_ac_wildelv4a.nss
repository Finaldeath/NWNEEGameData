//::///////////////////////////////////////////////
//:: FileName con_ac_wildelve4
//:: Frederick acknowledges quest completion and gives reward.
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 11/17/2005 4:53:00 PM
//:://////////////////////////////////////////////

#include "NW_I0_GENERIC"
#include "hf_in_xp"

void main()
{
    object oPC = GetPCSpeaker();

    // Set the variables
    SetLocalInt(oPC, "ac_wildelves_quest", 4);

    // Give the speaker the items
    CreateItemOnObject("nw_it_mneck025", oPC, 1);
    GiveScaledXPToCreature(oPC, 500);
    AddJournalQuestEntry("j56", 4, oPC);
}
