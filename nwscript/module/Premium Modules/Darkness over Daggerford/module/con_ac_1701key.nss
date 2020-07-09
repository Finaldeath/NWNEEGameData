//::///////////////////////////////////////////////
//:: FileName con_ac_1701key
//:: Callaway gives crypt key to player
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: January 7, 2006 6:58:10 PM
//:://////////////////////////////////////////////

#include "hf_in_plot"

void main()
{
    // Give the speaker the items
    CreateItemOnObject("ac_1702_key", GetPCSpeaker(), 1);
    AddJournalQuestEntry("j52",3,GetPCSpeaker());
    PlotLevelSet("ac_callaway", 1);
    PlotLevelSet(GetTag(OBJECT_SELF),1);
    //Allow conversation in case player quits conversation after getting key
    SetLocalInt(GetObjectByTag("ac_callaway"),"no_banter",0);
}
