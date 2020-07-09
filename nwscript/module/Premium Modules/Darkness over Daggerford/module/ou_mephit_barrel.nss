//summon a mephit and send a message to the PC
//Author: Damian Brown (Luspr)
//Date: 15-Aug-2005
#include "nw_i0_generic"
void main()
{

    object oPC = GetLastUsedBy();
    location lSpawn =GetLocation(GetWaypointByTag("wp_mephit"));

    if(!GetLocalInt(OBJECT_SELF,"mephit")==1)
    {
        SetLocalInt(OBJECT_SELF,"mephit",1);
        FloatingTextStringOnCreature("No wonder this water is so cold!",oPC);
        CreateObject(OBJECT_TYPE_CREATURE,"nw_mepice",lSpawn,TRUE,"ice_mephit");
        object oMephit = GetNearestObjectByTag("ice_mephit");
        SetIsTemporaryEnemy(oPC, oMephit);
        AssignCommand(oMephit, ActionAttack(oPC));
        AssignCommand(oMephit, DetermineCombatRound(oPC));
    }
    else
    {
        FloatingTextStringOnCreature("There is nothing else to do here.",oPC);
    }
}
