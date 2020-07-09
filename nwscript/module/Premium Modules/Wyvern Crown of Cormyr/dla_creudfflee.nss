// June 2003
// B W-Husey
// For: Creatures that flee the first time they see a PC, and shout a conversation line
// After this they behave normally. Uses the flee bahaviour flags from NWN - they're a bit temperamental but
// seem to work most of the time.
// This version is for hobgoblins (else change the sound)


#include "nw_i0_generic"

void main()
{
    object oPC = GetLastPerceived() ;
    int nUser = GetUserDefinedEventNumber();
    object oExitWay = GetWaypointByTag("EXIT_" + GetTag(OBJECT_SELF));
    if(nUser == 1002) // PERCEIVE
    {
//            ActionMoveToObject(oExitWay, TRUE);
            if (GetLocalInt(OBJECT_SELF,"nHostile")==0 && GetIsEnemy(oPC)==TRUE && GetDistanceToObject(oPC)<20.0){
            ClearAllActions(TRUE);
            SpeakOneLinerConversation("intruders");
            PlaySound("c_hobgob_slct");
            ActionForceMoveToObject(oExitWay, TRUE, 1.0, 30.0);
            SetLocalInt(OBJECT_SELF,"nHostile",1);
            SetCommandable(FALSE,OBJECT_SELF);           //Stop DetermineCombatRound() overiding flee orders
            DelayCommand(18.0,SetCommandable(TRUE,OBJECT_SELF));
            DelayCommand(19.0, WalkWayPoints());
            }
    }
    if(nUser == 1003) // END OF COMBAT ROUND
    {
//            ActionMoveToObject(oExitWay, TRUE);
            if (GetLocalInt(OBJECT_SELF,"nHostile")==0 && GetIsEnemy(oPC)==TRUE && GetDistanceToObject(oPC)<20.0){
            ClearAllActions(TRUE);
            SetLocalInt(OBJECT_SELF,"nHostile",1);
            SpeakOneLinerConversation("intruders");
            PlaySound("c_hobgob_slct");
            ActionForceMoveToObject(oExitWay, TRUE, 1.0, 10.0);
            SetCommandable(FALSE,OBJECT_SELF);           //Stop DetermineCombatRound() overiding flee orders
            DelayCommand(18.0,SetCommandable(TRUE,OBJECT_SELF));
            DelayCommand(19.0, WalkWayPoints());
            }
    }
}
