// apply a poison to a weapon
//   HF_ITEM_ONHIT_POISON = <poison constant>

#include "hf_in_poison"

void main()
{
    object oActivator  = GetItemActivator();
    object oItem       = GetItemActivated();
    object oTarget     = GetItemActivatedTarget();

    PoisonApply(oActivator, oItem, oTarget);
}
