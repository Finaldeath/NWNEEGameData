int StartingConditional()
{
    object oPC=GetPCSpeaker();
    if(GetGender(oPC)==GENDER_FEMALE)
    return TRUE;
    return FALSE;
}
