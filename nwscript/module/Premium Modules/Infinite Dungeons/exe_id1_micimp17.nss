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

    // stairs down
    int nStairsDownNum = GetLocalInt(oImport, "nLevel" + IntToString(nNum) + "StairsDown");
//    SetLocalInt(oImport, "nLevel" + IntToString(nNum) + "StairsDown", 0);
//    int nStairsDown = 1;
//    while (nStairsDown <= nStairsDownNum)
//    {
//        SetLocalInt(oImport, "nLevel" + IntToString(nNum) + "StairsDown" + IntToString(nStairsDown), 0);
//        nStairsDown++;
//    }

    // stairs up
//    int nStairsUpNum = GetLocalInt(oImport, "nLevel" + IntToString(nNum) + "StairsUp");
//    SetLocalInt(oImport, "nLevel" + IntToString(nNum) + "StairsUp", 0);
//    int nStairsUp = 1;
//    while (nStairsUp <= nStairsUpNum)
//    {
//        SetLocalInt(oImport, "nLevel" + IntToString(nNum) + "StairsUp" + IntToString(nStairsDown), 0);
//        nStairsUp++;
//    }

    // area X_Y
    int nMaxX = GetLocalInt(oImport, "nMaxX");
    int nMicroNum = GetLocalInt(GetModule(), "nImportMicroNum");
    object oMicroCPU;
    int nX = 1;
    while (nX <= nMaxX)
    {
        nMicroNum++;
        oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU84");
        SetLocalObject(oMicroCPU, "oImport", oImport);
        SetLocalInt(oMicroCPU, "nLevel", nNum);
        SetLocalInt(oMicroCPU, "nNum", nX);
        SetLocalObject(oMicroCPU, "oParent", oParent);
        DelayCommand(0.01, ExecuteScript("exe_id1_micimp22", oMicroCPU));

        nX++;
    }
    SetLocalInt(GetModule(), "nImportMicroNum", nMicroNum);

    // emergency creature num
    int nCreatureNum = GetLocalInt(oImport, "nEmergencyLevel" + IntToString(nNum) + "CreatureNum");
    SetLocalInt(oImport, "nEmergencyLevel" + IntToString(nNum) + "CreatureNum", 0);
    int nCreature = 1;
    while (nCreature <= nCreatureNum)
    {
        // item num
        SetLocalInt(oImport, "nEmergencyLevel" + IntToString(nNum) + "Creature" + IntToString(nCreature) + "ItemNum", 0);

        nCreature++;
    }

    // emergency placeable num
    int nPlaceableNum = GetLocalInt(oImport, "nEmergencyLevel" + IntToString(nNum) + "PlaceableNum");
    SetLocalInt(oImport, "nEmergencyLevel" + IntToString(nNum) + "PlaceableNum", 0);

    // emergency item num
    int nItemNum = GetLocalInt(oImport, "nEmergencyLevel" + IntToString(nNum) + "ItemNum");
    SetLocalInt(oImport, "nEmergencyLevel" + IntToString(nNum) + "ItemNum", 0);

    nMicroNum = GetLocalInt(GetModule(), "nImportMicroNum");
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
