
// November 2003
// B W-Husey
// PC has Persuade, and has not used it before.
// These generic scripts must ONLY be used once per character.
int StartingConditional()
{
    string sName ="PERS2"+GetTag(OBJECT_SELF);      //Set variable to object's tag
    int nOnce = GetLocalInt(GetPCSpeaker(), sName);  //Check to see if PC has tried this before
    // Make sure the player has the required skills
    if(!GetHasSkill(SKILL_PERSUADE, GetPCSpeaker()) || (nOnce>0))
        return FALSE;
    return TRUE;
}


