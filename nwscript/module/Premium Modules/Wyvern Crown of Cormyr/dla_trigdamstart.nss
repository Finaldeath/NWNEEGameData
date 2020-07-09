// November 2005
// B W-Husey
// Each time the PC enters this trigger, and as long as the main plot has progressed a bit, there is a chance the old man
// in the graveyard will rush over and tell the PC about the Damsel in Distress sidequest.
// Otherwise he prays.
#include "cu_functions"
//Check the animation works on the old man

void main()
{
 object oPC = GetEnteringObject();
 if (GetIsDefPC(oPC) && GetLocalInt(OBJECT_SELF,"nActive")==0) //if not the PC don't bother doing the rest.
 {
    SetLocalInt(OBJECT_SELF,"nActive",1);
    DelayCommand(60.0,SetLocalInt(OBJECT_SELF,"nActive",0)); //set a timer else the old man will be called lots or by multiple PCs
    //debug line *************
//    SendMessageToPC(oPC,"Old man called");
    object oOld = GetNearestObjectByTag("TOldMan");
    int nRand = Random(2);
    //tell the old man to pray 1 time in 2 (or the main plot is still very early)
        if (GetLocalInt(oPC,"nDamsel")>0)  //quest has run, scrap the trigger
        {
        DestroyObject(OBJECT_SELF,1.0);
        }
        else if (nRand==1 && GetLocalInt(oPC,"nMainPlot")>2)  //random true and suffuciently late in the mod to not overpower PC
        {
        AssignCommand(oOld,SpeakOneLinerConversation("oldhelp"));  //Run old man to PC shouting for help
        AssignCommand(oOld,ActionMoveToObject(oPC,TRUE));
        AssignCommand(oOld,DelayCommand(4.0,SpeakOneLinerConversation("oldhelp")));
        AssignCommand(oOld,ActionStartConversation(oPC,"damsel1",FALSE,FALSE));
        }
        else   //Pray
        {
        AssignCommand(oOld,SetFacing(90.0));
        AssignCommand(oOld,ActionPlayAnimation(ANIMATION_LOOPING_WORSHIP,1.0,20.0));
        }
 }
}
