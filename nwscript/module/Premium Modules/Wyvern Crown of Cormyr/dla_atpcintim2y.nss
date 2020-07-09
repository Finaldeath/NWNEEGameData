//February 2004
// B W-Husey
// PC has tried intimidate on this NPC. Special one on Huntcrown.

void main()
{
    string sName = "INTIM2y"+GetTag(OBJECT_SELF);      //Name variable
    SetLocalInt(GetPCSpeaker(), sName, TRUE);  //Set variable
}


