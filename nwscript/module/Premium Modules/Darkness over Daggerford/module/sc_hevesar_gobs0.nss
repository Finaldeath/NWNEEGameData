//player has not solved the Goblin Kitchens mission
int StartingConditional()
{
    if(!GetLocalInt(GetModule(),"kitchenquest")>0)
    return TRUE;
    return FALSE;
}
