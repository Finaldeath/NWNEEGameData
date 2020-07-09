//::///////////////////////////////////////////////
//:: FileName con_ac_jonasjrtu
//:: Jonas Jr. turns towards player
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: July 2, 2006
//:://////////////////////////////////////////////
void main()
{
object oPC = GetPCSpeaker();
object oJ = GetObjectByTag("ac_jonas2");
vector vLoc = GetPosition(oPC);
AssignCommand(oJ, ActionDoCommand(SetFacingPoint(vLoc)));
}
