//::///////////////////////////////////////////////
//:: FileName ohb_ac_jouka
//:: Jouka repairs wagons on heartbeat
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: January 1, 2006 2:50:30 PM
//:://////////////////////////////////////////////
void main()
{
    object oAnvil = GetObjectByTag("ac_jouka_wagon");
    object oSmith = OBJECT_SELF;
    if (GetLocalInt(oSmith,"HF_DISABLE_AM") != 0) return;
    if (IsInConversation(oSmith))return;
    if (GetLocalInt(oSmith,"smith")== 1)
    {
        ClearAllActions(TRUE);
        return;
    }
    ClearAllActions(TRUE);
    ActionAttack(oAnvil);
    SoundObjectPlay(GetObjectByTag("ac_snd_jouka"));
}


