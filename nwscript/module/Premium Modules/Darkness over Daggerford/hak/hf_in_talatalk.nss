// include file for tiny talking talarenne trapped in the gem

const string sTalaDlg = "at_buddyinaglobe";
const string sTalaGem = "db_buddyinaglobe";
const string sTalaPlc = "ks_pl_talatlk";

// does the player have tala's gem?
int TalaIsAvailable(object oPC)
{
    if (GetIsInCombat(oPC))
        return(FALSE);
    object oGem = GetItemPossessedBy(oPC, sTalaGem);
    return (GetIsObjectValid(oGem));
}

// tala appears beside the player
object TalaAppear(object oPC)
{
    object oTala = CreateObject(OBJECT_TYPE_PLACEABLE, sTalaPlc, GetLocation(oPC));
    return(oTala);
}

// tala whispers in the player's ear
void TalaWhisper(object oPC, int nBanterLevel=0)
{
    SetLocalInt(oPC, "HF_HENCHMAN_BANTER", nBanterLevel);
    AssignCommand(oPC, SpeakOneLinerConversation(sTalaDlg, oPC));
}

// tala talks to the player through an invisible placeable
void TalaTalk(object oPC, int nBanterLevel=0)
{
    // destroy any old talas hanging around
    object oTala = GetObjectByTag(sTalaPlc);
    if (GetIsObjectValid(oTala))
    {
        DestroyObject(oTala);
    }

    // create a new tala and start the dialog
    oTala = TalaAppear(oPC);
    SetLocalInt(oTala, "HF_HENCHMAN_BANTER", nBanterLevel);
    AssignCommand(oPC, ClearAllActions(TRUE));
    DelayCommand(0.25, AssignCommand(oPC, ActionStartConversation(oTala, sTalaDlg)));
}

// cleanup invisible tala placeables
void TalaCleanup(object oPC)
{
    object oTala = GetNearestObjectByTag(sTalaPlc, oPC);
    if (GetIsObjectValid(oTala))
    {
        DestroyObject(oTala);
    }
}
