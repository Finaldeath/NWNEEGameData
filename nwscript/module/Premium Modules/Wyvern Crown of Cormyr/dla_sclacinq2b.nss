// March 2006
// B W-Husey
// Conditional to test state of Ride for a Lady quest
/*  1= In progress
    2= (used only while return is happening)
    3= Returned horse
    4= Rejected */

// Var11 tests if it has been said before

//Gale 11 June, 2006:
//Returns TRUE if the horse owned by Lacinda is on oPC party.
int DLA_GetIsLacindasHorseOnParty(object oPC);

int StartingConditional()
{
    object oPC = GetPCSpeaker();

    // Inspect local variables
    if(GetLocalInt(oPC, "nLady") != 2)
        return FALSE; //not returning horse now

    //Check if we've had this node before
    string sName = "Var11" + GetTag(OBJECT_SELF);       //Set variable to object's tag + extra bit
    int    nOnce = GetLocalInt(oPC, sName);  //Check to see if PC has tried this before

    //if this node was never choosen before and the horse owned by Lacinda is
    //on oPC party, then show the node. if not, then don't show.
    return !nOnce  && DLA_GetIsLacindasHorseOnParty(oPC);
}

int DLA_GetIsLacindasHorseOnParty(object oPC)
{
    object oHench;
    int i;

    if (GetLocalInt(oPC, "bLacindasOwnedHorse"))
        return TRUE;
    else
        while (GetIsObjectValid(oHench = GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC, ++i)))
            if (GetLocalInt(oHench, "bLacindasOwnedHorse"))
                return TRUE;
    return FALSE;
}
