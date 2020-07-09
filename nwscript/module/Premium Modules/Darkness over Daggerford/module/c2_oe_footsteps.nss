void main()
{
 object oPC = GetEnteringObject();
 if (!GetIsPC(oPC)) return;
 SetFootstepType(FOOTSTEP_TYPE_SOFT,oPC);
}
