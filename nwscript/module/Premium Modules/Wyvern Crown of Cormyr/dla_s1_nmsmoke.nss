//::///////////////////////////////////////////////
//:: Nightmare : Smoke For Wyvern Crown
//:: DLA_S1_NMSMOKE.nss
//:://////////////////////////////////////////////
/*
    In the excitement of battle, the nightmare snorts and
    neighs with rage, filling the area with smoke.

    This provides concealment bonus to the nightmare.

    Additionally, the act of snorting is a free action the
    nightmare performs once per round in combat, and
    targets hit by the snorted cone of smoke suffer penalty
    in attack and damage.

    NOT FOR USE WITH ACTUAL NIGHTMARE. SPECIFICALLY WRITTEN
    FOR "TAILS" HORSES.
*/
//:://////////////////////////////////////////////
//:: Created By: gaoneng
//:: Created On: May 11, 2006
//:://////////////////////////////////////////////

#include "DLA_I0_CONST"

void main()
{
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,
                        SupernaturalEffect(EffectAreaOfEffect(AOE_MOB_NIGHTMARE_SMOKE)),
                        OBJECT_SELF);
}
