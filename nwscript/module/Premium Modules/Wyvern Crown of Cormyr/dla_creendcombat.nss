// B W-Husey
// October 2005
// For ballista firers.

void main()
{
//    object oNearest = GetNearestObject(OBJECT_TYPE_CREATURE);
    object oNearest = GetNearestCreature(CREATURE_TYPE_REPUTATION,REPUTATION_TYPE_ENEMY);
    if (GetIsEnemy(oNearest) && GetDistanceToObject(oNearest)<5.0)  //There are no friends between me and my enemy and he's less than 10 metres away...
        {
        ExecuteScript("nw_c2_default3", OBJECT_SELF);
        }
    else
        {
            ClearAllActions(TRUE);
//    if (Random(3)!=0) //doesn't fire every time to reduce shots.
        {
                // ********debug line**************
//                SendMessageToPC(GetFirstPC(),"end round says fire");

        PlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,2.0);
        DelayCommand(2.2,ClearAllActions());
        DelayCommand(2.5,ActionInteractObject(GetNearestObjectByTag("Ballista")));
        }

//            SetCommandable(FALSE,OBJECT_SELF);           //Stop DetermineCombatRound() overiding flee orders
//            DelayCommand(5.0,SetCommandable(TRUE,OBJECT_SELF));
        }
}
