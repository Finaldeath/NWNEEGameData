//April 2006
// B W-Husey
// Kathryn pickpocket trigger - these are automatic as they're for ambience/characterisation.

#include "cu_treasure"
void main()
{
    object oKat = GetEnteringObject();
    object oTarget = GetNearestObjectByTag("TheftTarget");
    string sName = GetName(oTarget);
    //Check if it's Kathryn, and if so do the pickpocket
    if (GetTag(oKat)=="Kathryn" && GetLocalInt(OBJECT_SELF,"nFired")<1)
    {
        AssignCommand(oKat,ClearAllActions());
        AssignCommand(oKat,ActionMoveToObject(oTarget,FALSE,0.7));
        SetLocalInt(OBJECT_SELF,"nFired",1);
        DelayCommand(1.0,AssignCommand(oKat,ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,0.5,1.5)));
        DelayCommand(2.0,GetTreasure("Minor",oKat,100));
        DelayCommand(2.0,SendMessageToPC(GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC),"Kathryn pickpockets "+sName));
        DestroyObject(OBJECT_SELF,2.2);
//        DelayCommand(1.9,AssignCommand(oKat,ActionDoCommand(SetCommandable(TRUE,oKat))));
//        SetCommandable(FALSE,oKat);
    }

}
