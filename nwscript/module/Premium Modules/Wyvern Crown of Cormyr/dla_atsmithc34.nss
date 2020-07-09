//October 2005
// B W-Husey
// Crafting process:
/*
Step 1  Set the cost based on the material chosen
Step 2  Record the weapon chosen
Step 3  Record how many shards
*/

//We chose steel
void main()
{
    object oPC = GetPCSpeaker();
    SetLocalInt(OBJECT_SELF,"nShards",4);
    SetLocalInt(OBJECT_SELF,"nBonus",GetLocalInt(OBJECT_SELF,"nBonus")+20);
}
