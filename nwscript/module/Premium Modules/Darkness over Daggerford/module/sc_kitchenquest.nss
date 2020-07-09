//player has solved the Goblin Kitchens mission
int StartingConditional()
{
    if(GetLocalInt(GetModule(),"kitchenquest")>0)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
