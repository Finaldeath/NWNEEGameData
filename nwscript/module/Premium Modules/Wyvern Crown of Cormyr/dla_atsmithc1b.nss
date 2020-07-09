//October 2005
// B W-Husey
// Crafting process:
/*
Step 1  Set the cost based on the material chosen. Set the bonus.

*/

//We chose adamantium
void main()
{
    object oPC = GetPCSpeaker();
    int nCost = GetLocalInt(oPC,"nCraftCost");
    int nSpecial;
    if (GetLocalInt(oPC,"nCraftAd")==1) nSpecial = 500;  //this PC has a special discount on adamantium
    nCost = (nCost*5)-nSpecial; //Adamantium costs 5 x Steel, less any discount.
    SetLocalInt(OBJECT_SELF,"nCost",nCost);
    SetLocalInt(OBJECT_SELF,"nBonus",5);
}
