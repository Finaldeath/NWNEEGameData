#include "hf_in_henchman"

void main()
{
    // if player vanishes, henchman must be removed otherwise corpse follows
    if (HenchmanIsDead(OBJECT_SELF))
    {
        object oPC = GetLastPerceived();
        if (GetIsObjectValid(oPC) && GetLastPerceptionVanished())
        {
            if (oPC == GetMaster())
            {
                if (GetArea(oPC) != GetArea(OBJECT_SELF))
                {
                    RemoveHenchman(oPC, OBJECT_SELF);
                }
            }
        }
    }

    if (!HenchmanIsPassive(OBJECT_SELF))
    {
        ExecuteScript("nw_ch_ac2", OBJECT_SELF);
    }
}

