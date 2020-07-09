// redeye's onAttacked/onSpell script; just vanish if attacked

void Escape()
{
    object oPC = GetFirstPC();
    AssignCommand(oPC, ClearAllActions(TRUE));
    ActionSpeakString("*hiss* Fool! You cannot hurtsss Redeye! *hiss*");
    ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT);
    PlaySound("as_an_lizhiss05");
    DelayCommand(2.5, AssignCommand(GetFirstPC(), SpeakString("... Redeye slips away into the swamp ...")));
    DestroyObject(OBJECT_SELF, 3.0);
}

void main()
{
    if (GetLocalInt(OBJECT_SELF, "nFlee") == 0)
    {
        SetLocalInt(OBJECT_SELF, "nFlee", 1);
        Escape();
    }
}
