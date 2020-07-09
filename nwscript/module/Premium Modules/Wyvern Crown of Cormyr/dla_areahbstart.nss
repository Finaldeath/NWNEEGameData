//March 2006
// B W-Husey
// Henchies should do some woodcutting type actions, while the player sorts themself out.
// This is being replaced with a cutscene

/*
void main()
{
    if (GetLocalInt(OBJECT_SELF,"sOff")==1)
    {
    int nRand = Random(3);
    object oGod = GetObjectByTag("Godfroy");
    object oJonas = GetObjectByTag("Jonas");
    location lLoc;


        switch (nRand)
        {
        case 1:
        lLoc = GetLocation(GetWaypointByTag("WP_StartAnim1"));
        AssignCommand(oGod,ActionMoveToLocation(lLoc));
        DelayCommand(3.0,AssignCommand(oGod,SetFacing(200.0)));
        DelayCommand(3.5,AssignCommand(oGod,ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0,2.0)));
        break;
/*
        case 2:
        object oTarget = GetNearestObjectByTag("TreeCut");
        lLoc = GetLocation(oTarget);
        AssignCommand(oGod,ClearAllActions());
        DelayCommand(0.1,AssignCommand(oGod,ActionMoveToLocation(lLoc)));
        DelayCommand(3.0,AssignCommand(oGod,ActionAttack(oTarget)));
        DelayCommand(6.0,AssignCommand(oGod,ClearAllActions()));
        break;


        }
    }
}
*/
