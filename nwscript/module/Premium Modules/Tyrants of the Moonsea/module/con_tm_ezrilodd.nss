//If PC has asked at least two questions to ascertain Ezril's identity,
//Ezril's odd behaviour is noticed
int StartingConditional()
{
    if(GetLocalInt(OBJECT_SELF, "iEzrilHeal") +
       GetLocalInt(OBJECT_SELF, "iEzrilNatureClass") +
       GetLocalInt(OBJECT_SELF, "iEzrilElenawen") +
       GetLocalInt(OBJECT_SELF, "iEzrilBranon") +
       GetLocalInt(OBJECT_SELF, "iEzrilAnimals") > 1)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
