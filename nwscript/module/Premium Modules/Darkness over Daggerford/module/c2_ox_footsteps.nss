// use as the onExit event of a water puddle
// .. just restores the creature's footsteps to normal

void main()
{
    object oPC = GetExitingObject();
    SetFootstepType(FOOTSTEP_TYPE_DEFAULT, oPC);
}
