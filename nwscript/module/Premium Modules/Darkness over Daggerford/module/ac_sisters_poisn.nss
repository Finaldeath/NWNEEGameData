//::///////////////////////////////////////////////
//:: FileName ac_sisters_poisn
//:: Sisters will proceed to drink and be poisoned to death
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 11/14/2005 11:59:20 PM
//:://////////////////////////////////////////////

#include "hf_in_cutscene"

void main()
{
    object oPC = GetPCSpeaker();
    object oElveronne = GetObjectByTag("ac_elveronne");

    // update the plot
    SetLocalInt(oElveronne, "poison", 1);
    SetLocalInt(oElveronne, "sisters_dead", 2);
    SetLocalInt(oPC, "sisters_dead", 1);
    SetLocalInt(GetArea(oPC), "nCut1Played", 1);

    // remove the poison
    object oItemToTake = GetItemPossessedBy(oPC, "ac_itm_poisonv");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);

    // play the cutscene
    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 0.5, 1.0));
    DelayCommand(1.0, FadeToBlack(oPC));
    DelayCommand(2.0, CutscenePlay(oPC, "mv_ar0701a_1"));
}
