#include "ddf_util"
#include "nw_i0_generic"

void main()
{
    object oPC = GetEnteringObject();

    if(GetIsPC(oPC) == FALSE) return;

    object oModule = GetModule();

    if(GetLocalInt(oModule, "ddf_has_triggered_ulan_warehouse") == TRUE) return;

    SetLocalInt(oModule, "ddf_has_triggered_ulan_warehouse", TRUE);

    debug("-- Ulan Encounter OnEnter");

    object oFactionMember = GetObjectByTag("UlanSlaverMember");
    object oNPC = GetFirstFactionMember(oFactionMember, FALSE);
    while(oNPC != OBJECT_INVALID)
    {
        debug("-- slaver attacking...");
        AssignCommand(oNPC, ActionAttack(oPC));
        oNPC = GetNextFactionMember(oFactionMember, FALSE);
    }

    // they should only flee if the pc does the conversation to release them.
    //MakeUlanWarehouseSlavesFlee();

}
