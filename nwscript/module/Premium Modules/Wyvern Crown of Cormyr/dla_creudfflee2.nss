// January 2006
// B W-Husey
// For: Creatures that flee the first time they see a PC
// This one is for the White Stag
// Last modified 12th June

#include "nw_i0_generic"

void main()
{
    object oPC = GetLastPerceived() ;
    int nUser = GetUserDefinedEventNumber();
    object oExitWay = GetWaypointByTag("WP_Stag");
    if(nUser == 1002 || nUser == 1005) // PERCEIVE or attacked
    {
//            ActionMoveToObject(oExitWay, TRUE);
            if (GetLocalInt(OBJECT_SELF,"nRunning")==0){
            ClearAllActions(TRUE);
            ActionForceMoveToObject(oExitWay, TRUE, 1.0, 60.0);
            SetLocalInt(OBJECT_SELF,"nRunning",1);
            SetCommandable(FALSE,OBJECT_SELF);           //Stop DetermineCombatRound() overiding flee orders
            DelayCommand(60.0,SetCommandable(TRUE,OBJECT_SELF));
            }
    }
    if(nUser == 1003) // END OF COMBAT ROUND
    {
//            ActionMoveToObject(oExitWay, TRUE);
            if (GetLocalInt(OBJECT_SELF,"nRunning")==0){
            ClearAllActions(TRUE);
            SetLocalInt(OBJECT_SELF,"nRunning",1);
            ActionForceMoveToObject(oExitWay, TRUE, 1.0, 60.0);
            SetCommandable(FALSE,OBJECT_SELF);           //Stop DetermineCombatRound() overiding flee orders
            DelayCommand(60.0,SetCommandable(TRUE,OBJECT_SELF));
            }
    }
    if(nUser == 1006) // DAMAGED
    {
        object oDamager = GetLastDamager();
            //**********debug line************
//            SendMessageToPC(oDamager,"Event run");
        if (GetIsObjectValid(oDamager))
        {
            int nWeapon = TRUE;
            if (GetDamageDealtByType(DAMAGE_TYPE_ACID) > 0 ||
            GetDamageDealtByType(DAMAGE_TYPE_COLD) > 2 ||
            GetDamageDealtByType(DAMAGE_TYPE_ELECTRICAL) > 0 ||
            GetDamageDealtByType(DAMAGE_TYPE_FIRE) > 0 ||
            GetDamageDealtByType(DAMAGE_TYPE_MAGICAL) > 2 ||
            GetDamageDealtByType(DAMAGE_TYPE_SONIC) > 2)
                nWeapon = FALSE;
            float fDist = GetDistanceToObject(oDamager);
            //**********debug line************
//            SendMessageToPC(oDamager,"Damage by weapon = "+IntToString(nWeapon));
            if (fDist>6.0 || GetIsWieldingRanged(oDamager) || nWeapon == FALSE)
            {
            //**********debug line************
//            SendMessageToPC(oDamager,"Want to destroy hide");
                DestroyObject(GetItemPossessedBy(OBJECT_SELF,"WhiteStagOK"));
                if (GetLocalInt(OBJECT_SELF,"nNewHide")<1)
                {
                    SetLocalInt(OBJECT_SELF,"nNewHide",1);
                    CreateItemOnObject("whitestagbad",OBJECT_SELF);
                }
            }
        }
    }
    if(nUser == 1007)
    {
         DelayCommand(5.0,MusicBattleStop(GetArea(OBJECT_SELF)));
         DelayCommand(6.0,MusicBattleChange(GetArea(OBJECT_SELF),60)); //change track
    }
}


