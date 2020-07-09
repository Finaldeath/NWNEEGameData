#include "nw_i0_2q4luskan"
void main()
{


    object oHawklin = GetNearestObjectByTag("SGHCastle");
    object oPC = GetEnteringObject();
    float fDelay = 0.0;
    MusicBattleChange(GetArea(oPC),51);
    MusicBattlePlay(GetArea(oPC));
    AssignCommand(oHawklin,ClearAllActions());
    AssignCommand(oHawklin,FaceNearestPC());
    AssignCommand(oPC,ClearAllActions());
    AssignCommand(oPC,SetFacingPoint(GetPosition(oHawklin)));
    AssignCommand(oHawklin,FaceNearestPC());
    AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_MEDITATE,1.0,10.0));
    DelayCommand(fDelay+=0.5,AssignCommand(oHawklin,ActionPlayAnimation(ANIMATION_LOOPING_CUSTOM4,1.0,3.0)));
    DelayCommand(fDelay+=4.0,AssignCommand(oHawklin,ActionPlayAnimation(ANIMATION_LOOPING_CUSTOM4,1.0,5.0)));
    DelayCommand(fDelay+=4.0,MusicBattleStop(GetArea(oPC)));
}
