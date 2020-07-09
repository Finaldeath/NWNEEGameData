//vampire gives reward after wedding
void main()
{
    if(GetLocalInt(OBJECT_SELF, "iGivenReward") == 0)
    {
        object oPC=GetPCSpeaker();
        if(!GetLevelByClass(CLASS_TYPE_CLERIC,oPC)==0||!GetLevelByClass(CLASS_TYPE_SORCERER,oPC)==0
        ||!GetLevelByClass(CLASS_TYPE_WIZARD,oPC)==0)
        {
            CreateItemOnObject("db_vampstaff",oPC,1);
        }
        else
        {
            CreateItemOnObject("db_vampamulet",oPC,1);
        }
        SetLocalInt(OBJECT_SELF, "iGivenReward", 1);
    }
}
