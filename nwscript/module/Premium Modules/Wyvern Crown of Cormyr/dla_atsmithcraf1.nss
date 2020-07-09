//October 2005
// B W-Husey
// Crafting process:
/*
Step 1  Set the cost based on the material chosen

*/

//We chose steel
void main()
{
    object oPC = GetPCSpeaker();
    int nCost = GetLocalInt(oPC,"nCraftCost");
    SetLocalInt(OBJECT_SELF,"nCost",nCost);
}
