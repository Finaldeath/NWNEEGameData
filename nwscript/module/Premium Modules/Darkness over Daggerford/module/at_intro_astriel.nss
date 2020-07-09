//set has met pc during intro - Amara
//Damian Brown (Luspr)

void main()
{
    object oPC = GetPCSpeaker();
    SetLocalInt(GetModule(), "amara_intro_metpc", 1);

    location lAstriel = GetLocation(GetWaypointByTag("WP_AR0600_ASTRIEL_END"));
    string sTag = GetTag(OBJECT_SELF);
    DelayCommand(0.5, AssignCommand(GetObjectByTag(sTag),
        ActionForceMoveToLocation(lAstriel)));

    object oFalias = GetNearestObjectByTag("db_falias3", oPC);
    if (GetIsObjectValid(oFalias))
    {
        DelayCommand(0.5, AssignCommand(oFalias, ActionStartConversation(oPC)));
    }
}
