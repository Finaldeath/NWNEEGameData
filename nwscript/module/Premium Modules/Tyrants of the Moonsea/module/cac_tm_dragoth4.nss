// player decides to attack dragoth after all
// sidequest: dragoth the bone mage

#include "hf_in_npc"
#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();

    // dragoth goes hostile
    GoHostile(OBJECT_SELF);

    // any remaining dragoth minions go hostile
    int n = 1;
    object oUndead = GetNearestObjectByTag("DragothMinion", oPC, n);
    while (GetIsObjectValid(oUndead))
    {
        GoHostile(oUndead);
        oUndead = GetNearestObjectByTag("DragothMinion", oPC, ++n);
    }
    object oJeeves = GetNearestObjectByTag("Jeeves", oPC);
    GoHostile(oJeeves);

    // player attacks dragoth
    PlotLevelSet("Dragoth", 5);
    AddJournalQuestEntry("DragothTheBoneMage", 50, oPC);
}
