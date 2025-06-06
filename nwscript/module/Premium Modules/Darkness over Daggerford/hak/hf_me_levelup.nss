#include "hf_in_henchman"

void main()
{
    object oPC = GetPCLevellingUp();

    // level-up henchmen that are currently "with" the player
    int i = 1;
    object oHench = GetHenchman(oPC, i);
    while (GetIsObjectValid(oHench))
    {
        HenchmanLevelUp(oHench, oPC);
        oHench = GetHenchman(oPC, ++i);
    }
}
