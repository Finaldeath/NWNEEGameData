//::///////////////////////////////////////////////
//:: FileName con_ac_purfinf
//:: Increase Purfbin's Influence variable by 1.
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 1/21/2006 10:51:56 PM
//:://////////////////////////////////////////////
void main()
{
object oPC = GetPCSpeaker();
int nInf = GetLocalInt(oPC, "ac_purfbin_influence");
nInf ++;
SetLocalInt(OBJECT_SELF, "ac_purfbin_influence", nInf);
}
