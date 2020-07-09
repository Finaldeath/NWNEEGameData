//February 2004
// B W-Husey
// PC has tried persuade on this NPC.

void main()
{
    string sName = "PERS2"+GetTag(OBJECT_SELF);      //Name variable
    SetLocalInt(GetPCSpeaker(), sName, TRUE);  //Set variable
}


