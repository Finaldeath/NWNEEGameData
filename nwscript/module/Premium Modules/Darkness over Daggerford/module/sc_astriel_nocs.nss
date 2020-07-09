//Starting Conditional for astriel in Chateau Elite
//PC has received reward but skipped cutscene execution by clicking on Astriel
//to restart conversation

int StartingConditional()
{
    int iResult;

    if(GetLocalInt(GetModule(),"the_blackstone_inn") == 3 &&
       GetLocalInt(GetModule(), "nAmaraHasLeftElite") == 0)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
