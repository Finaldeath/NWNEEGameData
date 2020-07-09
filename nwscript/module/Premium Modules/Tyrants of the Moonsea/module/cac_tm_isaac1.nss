// sidequest: "Ikathilo's Extraplanar Workshop" quest
// give the player the quest, which begins with a key that is used to open
// a door in the "Purple Portals" which contains a portal

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    object oKey = CreateItemOnObject("item051", oPC);
    if (GetIsObjectValid(oKey))
    {
        AddJournalQuestEntry("IkathilosExtraplanarWorkship", 10, oPC);
        PlotLevelSet("Isaac", 2);
    }
}
