
//December 2005
// B W-Husey
// PC has Bluff, and has not used it before. PC did not kill the witch lord.

int StartingConditional()
{
    string sName ="BLUFFWL"+GetTag(OBJECT_SELF);      //Set variable to object's tag
    object oPC = GetPCSpeaker();
    int nOnce = GetLocalInt(oPC, sName);  //Check to see if PC has tried this before
    if(!GetHasSkill(SKILL_BLUFF, oPC) || (nOnce>0))
        return FALSE;
    if(!(GetLocalInt(GetPCSpeaker(), "nWitchDead") == 0))
        return FALSE;
    return TRUE;
}


