#include "inc_id1_utility"

void main()
{
    object oImport = GetLocalObject(OBJECT_SELF, "oImport");
    object oParent = GetLocalObject(OBJECT_SELF, "oParent");

    DebugMessage("");
    DebugMessage("Specific import details.");

    // EDIT: clear specific import details
    DebugMessage("  Clearing specific dungeon numbers.");

    // boss teleporter
    SetLocalInt(oImport, "bBossTeleporter", FALSE);

    SetLocalInt(oImport, "bBossDead", FALSE);

    // boss activated
    SetLocalInt(oImport, "bBossActivated", FALSE);

    // boss level
//    SetLocalInt(oImport, "nBossLevel", 0);

    // boss detect
    SetLocalInt(oImport, "bBossDetect", FALSE);

//    SetLocalInt(oImport, "nBossQuest", 0);
//    SetLocalInt(oImport, "nBossQuestBoss", 0);
//    SetLocalInt(oImport, "nBossPlotDepth", 0);
//    SetLocalInt(oImport, "nBossPlotArea", 0);

    int nMicroNum = GetLocalInt(GetModule(), "nImportMicroNum");
    int nMicroDead = GetLocalInt(GetModule(), "nImportMicroDead");
    nMicroDead++;
    SetLocalInt(GetModule(), "nImportMicroDead", nMicroDead);
    DebugMessage("  There are " + IntToString(nMicroNum) + " living and " + IntToString(nMicroDead) + " dead microprocesses.");
    if (nMicroDead >= nMicroNum)
    {
        AssignCommand(oParent, ActionResumeConversation());
    }
    DelayCommand(0.01, DestroyObject(OBJECT_SELF));
}
