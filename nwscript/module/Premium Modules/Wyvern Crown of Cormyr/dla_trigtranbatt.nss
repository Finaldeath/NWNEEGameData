// February 2006
// B W-Husey
// Jump PC to Crown Barrow entrance when the battle is over

void main()
{
    object oPC = GetEnteringObject();
    if (GetLocalInt(oPC,"nBattleOver")==1)
    {
    AssignCommand(oPC,JumpToLocation(GetLocation(GetWaypointByTag("WP_CBE"))));
    }
    else
    {
    FloatingTextStringOnCreature("The enemy are approaching. You should get back to your army!",oPC);
    }
}
