//player has not solved orcs in the fields quest
int StartingConditional()
{
    if(!GetLocalInt(GetModule(),"fieldsquest")>0)
    return TRUE;
    return FALSE;
}
