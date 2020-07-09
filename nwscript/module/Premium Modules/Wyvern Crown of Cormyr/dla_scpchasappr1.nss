
//November 2003
// B W-Husey
// PC has Appraise, and has not used it before on this character.
// These generic scripts must ONLY be used once per character.

int StartingConditional()
{
    string sName = "APP"+GetTag(OBJECT_SELF);      //Set variable to object's tag
    int nOnce = GetLocalInt(GetPCSpeaker(), sName);  //Check to see if PC has tried this before
    // Make sure the player has the required skills
    if(!GetHasSkill(SKILL_APPRAISE, GetPCSpeaker()) || (nOnce>0))
        return FALSE;

    return TRUE;
}


