#include "inc_id1_utility"

void main()
{
    // feedback
    object oSpeaker = GetLocalObject(GetModule(), "oSpeaker");
    AssignCommand(oSpeaker, SpeakString("Retrieving previous dungeon."));

    // get previous dungeon
    int nDungeonNumber = GetLocalInt(GetModule(), "nPreviousDungeon");
    string sName = "Dungeon" + IntToString(nDungeonNumber);
    DebugMessage("Retrieving " + sName);
    location lLocation = GetLocation(GetObjectByTag("CPU"));
    object oDungeon = RetrieveCampaignObject("ID_DATABASE", sName, lLocation);
    if (oDungeon == OBJECT_INVALID)
    {
        DebugMessage("    Could not retrieve " + sName);
    } else
    {
        DebugMessage("    " + sName + " was retrieved.");
    }

    // set the current dungeon to the previous one
    SetLocalInt(GetModule(), "nDungeonNumber", nDungeonNumber);
    SetLocalObject(GetModule(), "oCurrentDungeon", oDungeon);
    DebugMessage("        Dungeon Number: " + IntToString(nDungeonNumber));

    DelayCommand(0.01, ExecuteScript("exe_id1_bosstel3", GetNextCPU()));
}
