//January 2006
// B W-Husey
// Variation on the Bluff2 generic sc script. PC lies about destroying the ball
// Has it or gave it to Wyvernvapor.

int StartingConditional()
{
    string sName ="BLUFF2"+GetTag(OBJECT_SELF);      //Set variable to object's tag
    object oPC = GetPCSpeaker();
    int nOnce = GetLocalInt(oPC, sName);  //Check to see if PC has tried this before
    int nBall = GetLocalInt(oPC,"nMyth");//what happened to the ball (2, has it, 3 gave it away)
    // Make sure the player has the required skills
    if(!GetHasSkill(SKILL_BLUFF, oPC) || (nOnce>0))
        return FALSE;
    if(nBall<2 || nBall>3)
        return FALSE;
    return TRUE;
}


