// when the player first walks by the girl selling books, she calls out

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        object oGirl = GetNearestObjectByTag("ks_golden_girl", oPC);
        if (GetIsObjectValid(oGirl))
        {
            AssignCommand(oGirl, SetFacingPoint(GetPosition(oPC)));
            AssignCommand(oGirl, SpeakOneLinerConversation());
            AssignCommand(oGirl, ActionPlayAnimation(ANIMATION_FIREFORGET_GREETING));
            DestroyObject(OBJECT_SELF);
        }
    }
}
