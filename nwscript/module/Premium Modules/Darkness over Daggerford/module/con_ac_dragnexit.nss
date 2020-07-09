void main()
{
object oPC = GetPCSpeaker();
object oTarget = GetObjectByTag("wp_ac_dragonexit");

FadeToBlack(oPC);
DelayCommand(0.5, FadeFromBlack(oPC));
AssignCommand(oPC, ClearAllActions());
AssignCommand(oPC, ActionJumpToObject(oTarget));

}
