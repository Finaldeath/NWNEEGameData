#include "dla_inc_darts"
void main()
{
    object oSelf = OBJECT_SELF;
    object oPC = GetPlaceableLastClickedBy();
    object oOpponent = GetLocalObject(oPC,"oMyDartOpponent");
    int nRound = GetDartRoundNumber();
    AssignCommand(oPC, ClearAllActions());
    //check dart permissions.  If it is not the PCs turn, or a game is not in progress,
    //bail out of the script.
    if(!GetLocalInt(oPC, "nMyDartTurn") ||
       !GetLocalInt(oPC,"nPlayingDarts"))
    {
        return;
    }

    int nTarget = GetLocalInt(oPC, "nDartTargetValue");
    int nShift = GetLocalInt(oSelf, "adjust_darttarget");
    string sFeedback = "Aiming for ";
    nTarget += nShift;
    if(nTarget>5){nTarget=5;}
    if(nTarget<0){nTarget=0;}
    switch(nTarget)
    {
        case 0:sFeedback+="the board";break;
        case 1:sFeedback+="4th circle or better";break;
        case 2:sFeedback+="3rd circle or better";break;
        case 3:sFeedback+="2nd circle or better";break;
        case 4:sFeedback+="1st circle or better";break;
        case 5:sFeedback+="bull's-eye";break;
    }
    FloatingTextStringOnCreature(sFeedback,oPC,FALSE);
    SetLocalInt(oPC, "nDartTargetValue",nTarget);
}
