//door option for the harpers room at the holfast inn
// fires once teygan gives the quest
void main()
{
    if(GetLocalInt(GetModule(),"teygan_quests")==3)
    {
        object oPC = GetClickingObject();
        ActionStartConversation(oPC);
    }
}
