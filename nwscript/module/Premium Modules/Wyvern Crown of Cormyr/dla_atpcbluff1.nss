//APRIL 2004
// B W-Husey
// PC has tried bluff on this NPC.

void main()
{
    string sName = "BLUFF"+GetTag(OBJECT_SELF);      //Name variable
    SetLocalInt(GetPCSpeaker(), sName, TRUE);  //Set variable
}


