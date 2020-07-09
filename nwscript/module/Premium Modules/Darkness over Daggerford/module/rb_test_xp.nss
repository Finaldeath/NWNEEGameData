#include "hf_in_xp"

void main()
{
    object oPC = GetLastUsedBy();

    GiveScaledXPToCreature(oPC, 500);
}
