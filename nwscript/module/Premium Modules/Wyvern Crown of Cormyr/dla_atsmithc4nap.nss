//October 2005
// B W-Husey
// Crafting process:
/*
Step 1  Set the cost based on the material chosen
Step 2  Record the weapon chosen
Step 3  Record how many shards
Step 4  Record which special ingredient we are using
*/

//We chose steel
void main()
{
    object oPC = GetPCSpeaker();
    string sString = "NapthaBlend";
    SetLocalString(OBJECT_SELF,"sSpecial",sString);
}
