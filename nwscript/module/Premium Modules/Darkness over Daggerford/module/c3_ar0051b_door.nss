// player exits zhent caravan tent
// .. any zhents outside will be angry (if they aren't already angry)

void main()
{
    object oClicker = GetClickingObject();
    object oTarget = GetTransitionTarget(OBJECT_SELF);
    AssignCommand(oClicker, JumpToObject(oTarget));
    if (GetIsPC(oClicker))
    {
        // iron throne guards outside will be hostile even if you bluff'd them
        int i = 0;
        object oArcher = GetObjectByTag("db_itarcher",i);
        while(oArcher != OBJECT_INVALID)
        {
             ChangeToStandardFaction(oArcher,STANDARD_FACTION_HOSTILE);
             oArcher = GetObjectByTag("db_itarcher",++i);
        }
        i = 0;
        object oWarrior = GetObjectByTag("db_itwarrior",i);
        while(oWarrior != OBJECT_INVALID)
        {
             ChangeToStandardFaction(oWarrior,STANDARD_FACTION_HOSTILE);
             oWarrior = GetObjectByTag("db_itwarrior",++i);
        }
        i = 0;
        object oWarrior2 = GetObjectByTag("db_itwarrior2",i);
        while(oWarrior2 != OBJECT_INVALID)
        {
             ChangeToStandardFaction(oWarrior2,STANDARD_FACTION_HOSTILE);
             oWarrior2 = GetObjectByTag("db_itwarrior2",++i);
        }
    }
}
