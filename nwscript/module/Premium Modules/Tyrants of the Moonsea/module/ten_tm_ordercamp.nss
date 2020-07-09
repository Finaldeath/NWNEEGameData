//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ten_tm_ordercamp
// DATE: April 1, 2006
// AUTH: Luke Scull
// NOTE: Floating text above player's head when he
//       enters the trigger, and int is set so that
//       Order Ambush cutscene fires when the player
//       attempts to stumble out of the camp.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF));

if (DoOnce==TRUE) return;

SetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF), TRUE);

AssignCommand(oPC, SpeakString("The campfires crackle and spit, bathing the deserted camp in an eerie red glow. The flap to the large tent before you hangs limply open, revealing nothing but scattered, worthless junk inside."));

SetLocalInt(oPC, "dracolich", 1);
}
