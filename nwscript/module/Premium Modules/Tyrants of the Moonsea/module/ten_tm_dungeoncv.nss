//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ten_tm_dungeoncv
// DATE: October 16, 2005
// AUTH: Luke Scull
// NOTE: If player has just been jumped in after Dazel
//       conversation, set cutscene mode and fade in
//       screen, then start next conversation.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

if (GetLocalInt(oPC, "dungeontrigger")!= 1)
   return;

if (GetLocalInt(OBJECT_SELF, "fired") == 1)
   return;

SetLocalInt(OBJECT_SELF, "fired", 1);

SetCutsceneMode(oPC, TRUE);

FadeFromBlack(oPC, FADE_SPEED_MEDIUM);

object oTarget = GetObjectByTag("DeputyDazel");

DelayCommand(1.5, AssignCommand(oTarget, ActionStartConversation(oPC, "")));

}

