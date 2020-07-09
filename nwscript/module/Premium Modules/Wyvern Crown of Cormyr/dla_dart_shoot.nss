void main()
{
    object oPC = GetPCSpeaker();
    object oSelf = OBJECT_SELF;
    int nFingers = GetLocalInt(oPC,"nDartFingers");
    int nRoll = d4();
    string sFeedback = GetName(oSelf)+": "+IntToString(nRoll)+" vs ";
    sFeedback += GetName(oPC)+": "+IntToString(nFingers)+" = **";
    nRoll += nFingers;
    int nRemain = nRoll%2;
    if(nRemain)
    {
        SetLocalInt(oPC,"nWonPregameShoot",TRUE);
        sFeedback += "Odd**";
    }
    else
    {
        SetLocalInt(oPC,"nWonPregameShoot",FALSE);
        sFeedback += "Even**";
    }
    ActionPauseConversation();
    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,1.0));
    AssignCommand(oSelf, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,1.0));
    DelayCommand(1.0, FloatingTextStringOnCreature(sFeedback,oPC));
    DelayCommand(2.0, ActionResumeConversation());
}
