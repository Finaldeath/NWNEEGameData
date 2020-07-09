//::///////////////////////////////////////////////
//:: File: cac_tm_hilrad8
//:://////////////////////////////////////////////
//:: Remove Dominion and starts cutscene
//:://////////////////////////////////////////////

#include "hf_in_cutscene"


const string NPC_TAG_SENTINEL = "TheSentinel";

// Removes henchmen only
void RemoveAllHenchmen(object oPC)
{
    object oHench = OBJECT_INVALID;
    int i = 0;

    for (i=16; i>0; i--)
    {
        oHench = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC, i);
        DelayCommand(1.0f, RemoveHenchman(oPC, oHench));
        SetActionMode(oHench, ACTION_MODE_STEALTH, FALSE);
    }
}


void main()
{
    object oItem;
    object oSentinel = GetObjectByTag(NPC_TAG_SENTINEL);
    object oPC = GetPCSpeaker();

    // Remove Dominion
    oItem = GetItemPossessedBy(oPC, "Dominion");
    if (GetIsObjectValid(oItem))
        DestroyObject(oItem);

    // Sets up Sentinel Dialog branch
    ExecuteScript("hf_ut_plot_s02", oSentinel);

    // RemoveAllHenchmen(oPC);

    CutscenePlay(oPC, "cut_tm_hilraddom");
}
