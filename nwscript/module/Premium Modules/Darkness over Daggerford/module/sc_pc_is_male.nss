int StartingConditional()
{
    object oPC=GetPCSpeaker();
    if(GetGender(oPC)==GENDER_MALE)
    return TRUE;
    return FALSE;
}
