//1 in 6 chance of dialog branch appearing
int StartingConditional()
{
    if(d6() == 1)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
