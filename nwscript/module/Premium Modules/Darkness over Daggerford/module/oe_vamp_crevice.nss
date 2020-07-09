//start conversation if the player's search result is
//greater than 12 and the plot is active
void main()
{
    object oPC=GetEnteringObject();
    object oTrigger=GetObjectByTag("crevice_lh1");

    if (GetIsPC(oPC)&&!GetIsInCombat(oPC)&&GetLocalInt(GetModule(),"rab_plot")>29&&
        GetLocalInt(GetModule(),"rab_plot")<55)
    {
        int nSearch=12;
        int nSkill=GetSkillRank(SKILL_SEARCH,oPC);
        if((d20()+nSkill)>=nSearch || (GetLocalInt(OBJECT_SELF, "iFound") == 1))
        {
            SetLocalInt(OBJECT_SELF, "iFound", 1);
            AssignCommand(oPC, ClearAllActions());
            AssignCommand(oTrigger, ActionStartConversation(oPC));
        }
    }
}
