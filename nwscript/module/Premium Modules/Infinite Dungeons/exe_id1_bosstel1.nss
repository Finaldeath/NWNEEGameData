#include "inc_id1_utility"

void main()
{
    // feedback
    object oSpeaker = GetLocalObject(GetModule(), "oSpeaker");
    AssignCommand(oSpeaker, SpeakString("Storing dungeon."));

    // store current dungeon
    object oDungeon = GetCurrentDungeon();
    int nDungeonNumber = GetLocalInt(GetModule(), "nDungeonNumber");
    if (nDungeonNumber != 0)
    {
        string sName = "Dungeon" + IntToString(nDungeonNumber);
        int bSuccess = StoreCampaignObject("ID_DATABASE", sName, oDungeon);
        DebugMessage("Success of storing of " + sName + " is " + IntToString(bSuccess));
        DestroyObject(oDungeon);
    }

    DelayCommand(0.01, ExecuteScript("exe_id1_bosstel2", GetNextCPU()));
}
