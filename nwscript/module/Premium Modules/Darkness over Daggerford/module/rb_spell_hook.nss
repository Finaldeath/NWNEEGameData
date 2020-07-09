#include "x2_inc_switches"
#include "inc_polymorph"

void main()
{
    int nSpell=GetSpellId();
    object oTarget = GetSpellTargetObject();

    switch (nSpell)
    {
        case 387:
        case 388:
        case 389:
        case 390:
        case 391:
        if(GetIsPC(oTarget) && IsPolymorphed(oTarget))
        {
            FloatingTextStringOnCreature("The hag's polymorph prevents further polymorph spells working.", oTarget);
            SetModuleOverrideSpellScriptFinished();
        }
        break;
    }
}
