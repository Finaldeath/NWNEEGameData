// January 2006
// Default Spawn for creatures in the final battle. Stripped out.
// B W-Husey
// Based on default Bioware script.

#include "x0_i0_anims"
#include "x2_inc_switches"
void main()
{
    int nNumber = GetLocalInt(OBJECT_SELF,CREATURE_VAR_NUMBER_OF_ATTACKS);
    if (nNumber >0 )
    {
        SetBaseAttackBonus(nNumber);
    }
    SetSpawnInCondition(NW_FLAG_SHOUT_ATTACK_MY_TARGET);
    SetListeningPatterns();
}
