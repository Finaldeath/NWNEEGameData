//January 2006
// B W-Husey
// nPiracy = 5 (Salvatori Dead) - bluff option (once only)

int StartingConditional()
{
    string sName ="BLUFF"+GetTag(OBJECT_SELF);      //Set variable to object's tag
    int nOnce = GetLocalInt(GetPCSpeaker(), sName);  //Check to see if PC has tried this before
    // Make sure the player has the required skills
    if(!GetHasSkill(SKILL_BLUFF, GetPCSpeaker()) || (nOnce>0))
        return FALSE;
    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nPiracy") == 5))
        return FALSE;

    return TRUE;
}
