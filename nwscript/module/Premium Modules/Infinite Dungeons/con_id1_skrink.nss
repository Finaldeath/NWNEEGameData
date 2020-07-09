int StartingConditional()
{
    // if bfollower is true and i dont have a master
    int bFollower = GetLocalInt(OBJECT_SELF, "bFollower");
    if (bFollower == TRUE)
    {
        object oMaster = GetMaster();
        if (oMaster == OBJECT_INVALID)
        {
            object oPC = GetPCSpeaker();
            AddHenchman(oPC);
        }
    }

    return TRUE;
}
