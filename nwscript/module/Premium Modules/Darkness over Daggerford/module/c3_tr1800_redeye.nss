// when the player walks past redeye in AR1900, he calls to the player

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        if (GetLocalInt(OBJECT_SELF, "nDone") == 0)
        {
            SetLocalInt(OBJECT_SELF, "nDone", 1);
            object oRedeye = GetNearestObjectByTag("ks_redeye", oPC);
            if (GetIsObjectValid(oRedeye))
            {
                AssignCommand(oPC, ClearAllActions());
                AssignCommand(oRedeye, ClearAllActions());
                AssignCommand(oRedeye, PlaySound("as_an_lizhiss05"));
                AssignCommand(oRedeye, ActionSpeakString("*hiss* Come over here. Yessss?"));
                AssignCommand(oRedeye, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
            }
            DestroyObject(OBJECT_SELF);
        }
    }
}
