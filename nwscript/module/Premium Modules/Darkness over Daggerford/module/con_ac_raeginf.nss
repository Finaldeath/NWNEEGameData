//::///////////////////////////////////////////////
//:: FileName con_ac_raeginf
//:: Increase Raegen's Influence variable by 1.
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 2/5/2006 10:51:56 PM
//:://////////////////////////////////////////////
void main()
{
object oPC = GetPCSpeaker();
int nInf = GetLocalInt(oPC, "ac_raegen_influence");
nInf ++;
SetLocalInt(OBJECT_SELF, "ac_raegen_influence", nInf);
}
