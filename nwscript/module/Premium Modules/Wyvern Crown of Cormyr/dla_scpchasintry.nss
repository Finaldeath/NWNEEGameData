
//November 2003
// B W-Husey
// PC has tried Intim1
// These generic scripts must ONLY be used once per character.
int StartingConditional()
{
    string sName = "INTIM"+GetTag(OBJECT_SELF);      //Set variable to object's tag
    int nOnce = GetLocalInt(GetPCSpeaker(), sName);  //Check to see if PC has tried this before
    // Make sure the player has the required skills
    if(nOnce>0)
        return TRUE;

    return FALSE;
}


