void main()
{
object oPC = GetPCSpeaker();
object oTarget = GetObjectByTag("wp_at_well");

AssignCommand(oPC, ClearAllActions());
AssignCommand(oPC, ActionJumpToObject(oTarget));
DestroyObject(GetObjectByTag("ac_burnas"));
object oD = CreateObject(OBJECT_TYPE_CREATURE, "ac_dalia", GetLocation(GetObjectByTag("wp_ac_dalia")));
DelayCommand(1.0, AssignCommand(oD, ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK, 1.0, 99999999.0)));
}
