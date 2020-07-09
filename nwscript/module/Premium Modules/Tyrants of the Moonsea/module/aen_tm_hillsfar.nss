//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: aen_tm_hillsfar
// DATE: November 23, 2005
// AUTH: Luke Scull
// NOTE: Sets int so player can use  the Scroll of
//       Illusion once they enter Hillsfar: Merchant's
//       District.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
    object oPC = GetEnteringObject();
    if(GetIsPC(oPC) && GetLocalInt(OBJECT_SELF, "nEntered") != 1)
    {
        SetLocalInt(oPC, "outsidehillsfar", 1);
        SetLocalInt(OBJECT_SELF, "nEntered", 1);
        ExploreAreaForPlayer(GetArea(oPC), oPC, TRUE);
    }
}
