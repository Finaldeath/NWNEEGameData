// return true if we are speaking with another NPC
int StartingConditional()
{
    // check if the PC started talking to us
    object oPC = GetPCSpeaker();
    if (!GetIsObjectValid(oPC))
    {
        // are we talking to another NPC or to the PC?
        object oFriend = GetLocalObject(OBJECT_SELF, "HF_DIALOG_TARGET");
        if (GetIsObjectValid(oFriend))
        {
            if (!GetIsPC(oFriend))
            {
                return(TRUE);
            }
        }
    }
    return(FALSE);
}

