//November 2003
// B W-Husey
// PC has tried lore on this NPC.

void main()
{
    string sName = "LORE"+GetTag(OBJECT_SELF);      //Name variable
    SetLocalInt(GetPCSpeaker(), sName, TRUE);  //Set variable
}


