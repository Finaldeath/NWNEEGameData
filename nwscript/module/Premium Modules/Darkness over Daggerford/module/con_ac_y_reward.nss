//con_ac_y_reward
//Give PC reward for killing Yentai.
//Author: Alan Tarrant
//Date: December 18, 2005

void main()
{
    int iR = GetLocalInt(OBJECT_SELF, "yentai_reward");
    object oPC = GetPCSpeaker();
    GiveGoldToCreature(oPC,iR);
    SetLocalInt(GetPCSpeaker(), "ac_cheese_quest", 6);
    GiveXPToCreature(GetPCSpeaker(),750);
    object oItem = GetItemPossessedBy(oPC, "ac_yentai_amulet");
    if (GetIsObjectValid(oItem))
    {
        DestroyObject(oItem);
    }
    AddJournalQuestEntry("j54", 11, oPC, TRUE, TRUE, TRUE);
}
