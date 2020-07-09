// January 2006
// B W-Husey
// PC blows the order for a general assault  - all the good guys run across the battle field.

void main()
{
    object oLoc = GetWaypointByTag("WP_Assault");
    object oSoldier = GetObjectByTag("Goodie",1);
    object oSound = GetObjectByTag("SoundTrumpet");
    SoundObjectPlay(oSound);
    int nCount = 1;
//    SendMessageToPC(OBJECT_SELF,"Horn sounds");
    while (oSoldier != OBJECT_INVALID)
      {
        AssignCommand(oSoldier,ClearAllActions(TRUE));
        AssignCommand(oSoldier,ActionMoveToObject(oLoc,TRUE,5.0));
        oSoldier = GetObjectByTag("Goodie",1+nCount);
        nCount++;
      }

}
