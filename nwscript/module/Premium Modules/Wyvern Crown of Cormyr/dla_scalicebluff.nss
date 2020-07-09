
//December 2005
// B W-Husey
// PC has Bluff, and has not used it before. PC either gave the horn to Huntcrown or used it themself.

int StartingConditional()
{
    string sName ="BLUFFX"+GetTag(OBJECT_SELF);      //Set variable to object's tag
    object oPC = GetPCSpeaker();
    int nOnce = GetLocalInt(oPC, sName);  //Check to see if PC has tried this before
    int nYes = 0;
    // Make sure the player has the required skills
    int nQuest = GetLocalInt(oPC,"nToOrder");
    if (nQuest == 3 || nQuest == 4) nYes = 1;
    if(!GetHasSkill(SKILL_BLUFF, oPC) || (nOnce>0) || nYes<1)
        return FALSE;
    return TRUE;
}


