// player exits the piranha pool

void main()
{
    object oPC = GetExitingObject();
    SetFootstepType(FOOTSTEP_TYPE_DEFAULT, oPC);
    SetLocalInt(oPC, "nBitingFish", 0);
    DeleteLocalObject(oPC, "nBitingFishPool");
}
