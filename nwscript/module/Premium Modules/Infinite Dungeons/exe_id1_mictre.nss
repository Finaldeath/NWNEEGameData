#include "inc_id1_debug"
//#include "inc_id1_creature"
#include "inc_id1_treasure"

void main()
{
    // get variables
    int nLevel = GetLocalInt(OBJECT_SELF, "nLevel");
    string sContainer = GetLocalString(OBJECT_SELF, "sContainer");
    float fValueMultiplier = GetLocalFloat(OBJECT_SELF, "fValueMultiplier");
    int bGoldPresent = GetLocalInt(OBJECT_SELF, "bGoldPresent");
    int bGemPresent = GetLocalInt(OBJECT_SELF, "bGemPresent");
    int bItemPresent = GetLocalInt(OBJECT_SELF, "bItemPresent");
    int bCreateTreasure = GetLocalInt(OBJECT_SELF, "bCreateTreasure");
    object oContainer = GetLocalObject(OBJECT_SELF, "oContainer");
    object oDungeon = GetLocalObject(OBJECT_SELF, "oDungeon");
    int bHold = GetLocalInt(OBJECT_SELF, "bHold");

    DebugMessage("");
    DebugMessage("====TREASURE GENERATION MICROPROCESS START====");
    DebugMessage("==== " + sContainer + " ====");
    DebugMessage("");

    DebugMessage("  nLevel is " + IntToString(nLevel));
    DebugMessage("  sContainer is " + sContainer);
    DebugMessage("  fValueMultiplier is " + FloatToString(fValueMultiplier));
    DebugMessage("  bGoldPresent is " + IntToString(bGoldPresent));
    DebugMessage("  bGemPresent is " + IntToString(bGemPresent));
    DebugMessage("  bItemPresent is " + IntToString(bItemPresent));
    DebugMessage("  bCreateTreasure is " + IntToString(bCreateTreasure));

    // EDIT: grab treasure min and max level range based on module flags
    int nMinLevelAdjustment = 0;
    int nMaxLevelAdjustment = 0;

    // generate the treasure data
    GenerateTreasure(nLevel, nMinLevelAdjustment, nMaxLevelAdjustment, fValueMultiplier, bGoldPresent, bGemPresent, bItemPresent, bCreateTreasure, sContainer, oContainer, oDungeon);

    if (bHold == TRUE)
    {
        // increment, showing that this process is finished
        int nMicroDead = GetLocalInt(GetModule(), "nMicroDead");
        nMicroDead++;
        SetLocalInt(GetModule(), "nMicroDead", nMicroDead);
    }

    DebugMessage("");
    DebugMessage("==== " + sContainer + " ====");
    DebugMessage("====TREASURE GENERATION MICROPROCESS END====");
    DebugMessage("");

    // destroy itself
    DelayCommand(0.1, DestroyObject(OBJECT_SELF));
}
