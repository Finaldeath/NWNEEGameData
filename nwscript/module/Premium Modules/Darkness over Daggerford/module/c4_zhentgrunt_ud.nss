// zhent grunts talk about dwarf disposal
// .. veiti attacks them after a while

void main()
{
    object oBuddy;
    if (GetTag(OBJECT_SELF) == "ks_ill_zhent1")
        oBuddy = GetNearestObjectByTag("ks_ill_zhent2", OBJECT_SELF);
    else
        oBuddy = GetNearestObjectByTag("ks_ill_zhent1", OBJECT_SELF);
    int nUser = GetUserDefinedEventNumber();
    string q = GetLocalString(GetModule(), "QUOTE");

    if (nUser == 1)
    {
        if (!GetIsInCombat(OBJECT_SELF))
        {
            SpeakString(q+"How'd we get stuck doin' this stupid dwarf cleanup job?"+q);
            PlayAnimation(ANIMATION_FIREFORGET_PAUSE_BORED);
            DelayCommand(8.0, SignalEvent(oBuddy, EventUserDefined(2)));
        }
    }
    else if (nUser == 2)
    {
        if (!GetIsInCombat(OBJECT_SELF))
        {
            SpeakString(q+"Old Skron has it in for us. But it sure was fun to gut those dwarves and keep them around as trophies!"+q);
            PlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 8.0);
            DelayCommand(10.0, SignalEvent(oBuddy, EventUserDefined(3)));
        }
    }
    else if (nUser == 3)
    {
        if (!GetIsInCombat(OBJECT_SELF))
        {
            SpeakString(q+"Well, I hate this! These dwarves stink! Actually...I think they stunk before we killed 'em!"+q);
            PlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 8.0);
            DelayCommand(10.0, SignalEvent(oBuddy, EventUserDefined(4)));
        }
    }
    else if (nUser == 4)
    {
        if (!GetIsInCombat(OBJECT_SELF))
        {
            SpeakString(q+"So long, Mr. Dwarf. Don't muss your beard on the way down!"+q);
            PlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 6.0);
            DelayCommand(8.0, SignalEvent(oBuddy, EventUserDefined(5)));
        }
    }
    else if (nUser == 5)
    {
        object oVeiti = GetNearestObjectByTag("db_veiti", OBJECT_SELF);
        if (GetIsObjectValid(oVeiti))
        {
            if (!GetIsInCombat(oVeiti))
            {
                object oSelf = OBJECT_SELF;
                AssignCommand(oVeiti, ClearAllActions());
                AssignCommand(oVeiti, SpeakString(q+"Argh! Them's my kin!"+q));
                AssignCommand(oVeiti, ActionAttack(oSelf));
                SignalEvent(oBuddy, EventUserDefined(9));
                SignalEvent(OBJECT_SELF, EventUserDefined(9));
            }
        }
    }
    else if (nUser == 9)
    {
        ChangeToStandardFaction(OBJECT_SELF, STANDARD_FACTION_HOSTILE);
        if (!GetIsInCombat(OBJECT_SELF) && !GetIsDead(OBJECT_SELF))
        {
            if (GetTag(OBJECT_SELF) == "ks_ill_zhent1")
            {
                SpeakString(q+"Hey! Who are you?"+q);
            }
            else
            {
                SpeakString(q+"Get 'em!"+q);
            }
            ActionAttack(GetFirstPC());
        }
    }
}
