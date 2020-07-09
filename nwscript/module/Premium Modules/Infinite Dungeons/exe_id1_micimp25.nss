#include "inc_id1_utility"

void main()
{
    object oImport = GetLocalObject(OBJECT_SELF, "oImport");
    int nNum = GetLocalInt(OBJECT_SELF, "nNum");
    object oParent = GetLocalObject(OBJECT_SELF, "oParent");

    DebugMessage("");
    DebugMessage("Specific import details.");

    // EDIT: clear specific import details
    DebugMessage("  Cleaning details for level " + IntToString(nNum));

    // emergency creature num
    int nCreatureNum = GetLocalInt(oImport, "nEmergencyLevel" + IntToString(nNum) + "CreatureNum");
    SetLocalInt(oImport, "nEmergencyLevel" + IntToString(nNum) + "CreatureNum", 0);
    int nCreature = 1;
    int nCreatureItemNum;
    int nCreatureItem;
    while (nCreature <= nCreatureNum)
    {
        SetLocalInt(oImport, "bEmergencyLevel" + IntToString(nNum) + "Creature" + IntToString(nCreature) + "Dead", FALSE);

        // item num
        nCreatureItemNum = GetLocalInt(oImport, "nEmergencyLevel" + IntToString(nNum) + "Creature" + IntToString(nCreature) + "ItemNum");
        nCreatureItem = 1;
        while (nCreatureItem <= nCreatureItemNum)
        {
            SetLocalInt(oImport, "bEmergencyLevel" + IntToString(nNum) + "Creature" + IntToString(nCreature) + "Item" + IntToString(nCreatureItem) + "Taken", FALSE);
            nCreatureItem++;
        }

        nCreature++;
    }

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
