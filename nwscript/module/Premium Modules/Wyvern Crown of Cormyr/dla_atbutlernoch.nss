//December 2005
// B W-Husey
// Butler won't give directions again for a while

void main()
{
    object oPC = GetPCSpeaker();
    // Set the variables
    SetLocalInt(oPC, "nITalk", 1);
    DelayCommand(300.0,SetLocalInt(oPC, "nITalk", 0));

}
