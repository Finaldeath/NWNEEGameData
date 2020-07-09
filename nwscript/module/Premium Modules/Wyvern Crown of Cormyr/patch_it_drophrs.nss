//::PATCH HISTORY
//::mm/dd/yyyy | MODIFIED BY      | DESCRIPTION
//::09/16/2006 | Deva B. Winblood | Created for patch 1 to handle stuck horse
//::           |                  | issues


#include "dla_i0_horse"

void main()
{
    object oItem=GetItemActivated();
    object oTarget=GetItemActivatedTarget();
    if (DLA_GetIsDLAHorse(oTarget))
    { // is a horse
        SetCommandable(TRUE,oTarget);
        AssignCommand(oTarget,SetIsDestroyable(TRUE));
        SetAILevel(oTarget,AI_LEVEL_DEFAULT);
        DLA_DespawnPaladinMount(oTarget);
        DestroyObject(oItem);
    } // is a horse
}
