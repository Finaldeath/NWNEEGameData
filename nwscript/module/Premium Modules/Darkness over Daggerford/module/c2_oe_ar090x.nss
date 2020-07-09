#include "hf_in_spawn"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        // pc's been to this area, mark them as such
        // for purposes of eliminating ogres/gnolls

        string sTag = GetTag(OBJECT_SELF);
        string sVar = ("nWH_Been_" + sTag);
        SetLocalInt(oPC, sVar, 1);

        SpawnEnter(oPC);
    }
}
