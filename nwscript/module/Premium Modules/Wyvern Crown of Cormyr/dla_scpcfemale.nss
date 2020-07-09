// April 2004
// B W-Husey
// PC is female only

int StartingConditional()
{

    // Add the gender restrictions
    if(GetGender(GetPCSpeaker()) != GENDER_FEMALE)
        return FALSE;

    return TRUE;
}
