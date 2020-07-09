// January 2006
// B W-Husey
// PC blows the retreat - all good guys return to their posts

void main()
{
    object oSoldier = GetObjectByTag("Goodie",1);
    int nCount = 1;
    object oSound = GetObjectByTag("SoundTrumpet");
    SoundObjectPlay(oSound);
//    SendMessageToPC(OBJECT_SELF,"HornSounds");
    // find each soldier and get the post stored on them, and order them to it.
    while (oSoldier != OBJECT_INVALID)
      {
        AssignCommand(oSoldier,ClearAllActions(TRUE));
        AssignCommand(oSoldier,ActionMoveToObject(GetObjectByTag(GetLocalString(OBJECT_SELF,"Post")),TRUE,0.0));
        AssignCommand(oSoldier,DelayCommand(6.0,SetCommandable(TRUE,OBJECT_SELF)));
        AssignCommand(oSoldier,SetCommandable(FALSE,OBJECT_SELF));
        oSoldier = GetObjectByTag("Goodie",1+nCount);
        nCount++;
      }

}

