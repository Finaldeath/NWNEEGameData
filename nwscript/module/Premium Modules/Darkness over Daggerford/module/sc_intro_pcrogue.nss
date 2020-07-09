//is the pc a Rogue?
//Damian Brown (Luspr)
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if(GetLevelByClass(CLASS_TYPE_ROGUE,oPC)>0)
    return TRUE;
    return FALSE;
}
