// chateau elite heartbeat for upper floor
// .. after the zhents attack cutscene battle, astriel continues her conversation

// returns true if all creatures with this tag in this area are dead
int AllDead(string sTag, object oSelf)
{
    int nRc = TRUE;
    int i = 1;
    object oZhent = GetNearestObjectByTag(sTag, oSelf, i);
    while (GetIsObjectValid(oZhent))
    {
        if (!GetIsDead(oZhent))
        {
            // found a living zhent
            nRc = FALSE;
            break;
        }
        oZhent = GetNearestObjectByTag(sTag, oSelf, ++i);
    }
    return(nRc);
}

void main()
{
    object oArea = OBJECT_SELF;
    if (GetLocalInt(oArea, "Cutscene_Fired") == 1)
    {
        // the cutscene has played
        object oAstriel = GetObjectByTag("pm_astriel2");
        object oPC = GetFirstPC();
        if (AllDead("_zhent_ar0101", oAstriel) &&
            !IsInConversation(oAstriel) && !IsInConversation(oPC) &&
            !GetIsInCombat(oPC) && !GetIsInCombat(oAstriel))
        {
            // all the zhents are gone, so astriel can talk to player
            effect eDispel = EffectDispelMagicAll(20);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDispel, oAstriel);
            AssignCommand(oPC, ClearAllActions(TRUE));
            AssignCommand(oAstriel, ClearAllActions(TRUE));
            AssignCommand(oAstriel, ActionStartConversation(oPC, "", FALSE, FALSE));

            // don't try this more than once
            SetLocalInt(oArea, "Cutscene_Fired", 0);
        }
    }
}
