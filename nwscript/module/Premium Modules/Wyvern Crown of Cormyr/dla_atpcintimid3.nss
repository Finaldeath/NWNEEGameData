//February 2004
// B W-Husey
// PC has tried intimidate on this NPC.

void main()
{
    string sName = "INTIM3"+GetTag(OBJECT_SELF);      //Name variable
    SetLocalInt(GetPCSpeaker(), sName, TRUE);  //Set variable
}


