// simple dice game that doesn't really do anything useful

void main()
{
    object oPlayer = GetLastUsedBy();
    string sPlayerName = GetName(oPlayer);

    int nRoll1 = Random(6) + 1;
    int nRoll2 = Random(6) + 1;

    SpeakString(sPlayerName + " rolls the dice.");
    AssignCommand(oPlayer, ActionPlayAnimation(ANIMATION_FIREFORGET_STEAL));
    DelayCommand(2.0f, PlaySound("fs_wood_hard1"));
    DelayCommand(2.1f, (SpeakString(sPlayerName + " rolls " + IntToString(nRoll1) + " and " + IntToString(nRoll2))));
}
