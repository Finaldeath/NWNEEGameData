
//November 2003
// B W-Husey
// PC has Intimidate, and has not used it before.
// These generic scripts must ONLY be used once per character.This version is only used for rumour dialogues, so that the rumour dialogue can
// be applied to any NPC without fear of a variables clash.
int StartingConditional()
{
    string sName = "INTIMr"+GetTag(OBJECT_SELF);      //Set variable to object's tag
    int nOnce = GetLocalInt(GetPCSpeaker(), sName);  //Check to see if PC has tried this before
    // Make sure the player has the required skills
    if(!GetHasSkill(SKILL_INTIMIDATE, GetPCSpeaker()) || (nOnce>0))
        return FALSE;

    return TRUE;
}


