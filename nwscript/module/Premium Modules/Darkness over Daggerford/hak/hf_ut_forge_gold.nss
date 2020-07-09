// does the player have enough gold to forge the selected item?

#include "hf_in_forge"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nChoice = GetLocalInt(OBJECT_SELF, "HF_ARG");
    return(!ForgeHasEnoughGold(OBJECT_SELF, oPC, nChoice));
}
