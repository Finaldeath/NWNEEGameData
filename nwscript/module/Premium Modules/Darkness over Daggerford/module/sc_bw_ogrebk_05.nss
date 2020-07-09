// returns TRUE if PC crossed the ogre bridge at least once,
// paying the toll

int StartingConditional()
{
    object oPC = GetPCSpeaker();

    if (GetLocalInt(oPC, "nWH_CrossedOnce") == 1) return TRUE;
    else return FALSE;
}
