// when the player touches one of the heads in the marsh the lizards ambush

#include "hf_in_spawn"

void main()
{
    if (GetLocalInt(OBJECT_SELF, "HF_ARG") == 0)
    {
        SetLocalInt(OBJECT_SELF, "HF_ARG", 1);

        // compute CR for this encounter
        object oPC = GetPCSpeaker();
        int nCR = SpawnGetPartyCR(oPC, 25);

        int i = 1;
        object oWP = GetNearestObjectByTag("WP_AR1800_LIZMAN_1", oPC, i);
        while (GetIsObjectValid(oWP))
        {
            object oLiz = CreateObject(OBJECT_TYPE_CREATURE, "ks_lizman2", GetLocation(oWP));
            SpawnLevelupCreature(oLiz, nCR);
            AssignCommand(oLiz, ActionAttack(oPC));
            oWP = GetNearestObjectByTag("WP_AR1800_LIZMAN_1", oPC, ++i);
        }
    }
}
