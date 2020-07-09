#include "nw_i0_generic"
void main()
{
    object oRender = GetObjectByTag("db_render");
    object oPC=GetPCSpeaker();
    AssignCommand(oPC,ActionAttack(oRender));
    SetLocalInt(GetModule(),"render",1);
    //AssignCommand(oRender,SetIsTemporaryEnemy(oPC));
    //AssignCommand(oRender,DetermineCombatRound(oPC));
}
