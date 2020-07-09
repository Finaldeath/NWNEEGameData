//APRIL 2004
// B W-Husey
// PC has tried taunt on this NPC.

void main()
{
    string sName = "TAUNT"+GetTag(OBJECT_SELF);      //Name variable
    SetLocalInt(GetPCSpeaker(), sName, TRUE);  //Set variable
}


