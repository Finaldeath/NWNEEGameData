string sDeny;

void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "leavevoonlar");

if (nInt < 1)
   {
   sDeny="You'd better investigate the attack at the Boring Pig before leaving town.";

   SendMessageToPC(oPC, sDeny);

   return;
   }


object oTarget;
location lTarget;
oTarget = GetWaypointByTag("WP_ShindRoadEast_To_Voonlar");

lTarget = GetLocation(oTarget);


if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;

AssignCommand(oPC, ClearAllActions());

AssignCommand(oPC, JumpToLocation(lTarget));

}


