//November 2003
// B W-Husey
// PC has tried appraise on this NPC.

void main()
{
    string sName = "APP"+GetTag(OBJECT_SELF);      //Name variable
    SetLocalInt(GetPCSpeaker(), sName, TRUE);  //Set variable
}


