//check to see if the escape route for prisoners is free from orcs
//if it is run away
//Author: Damian Brown (Luspr)
//Date:16-Aug-2005
int StartingConditional()
{
   // object oPC = GetPCSpeaker();
   // object oOrc1 = GetNearestObjectByTag("db_dropofforc",oPC);
   // object oOrc2 = GetNearestObjectByTag("db_orcarcher",oPC);
   // if(!GetIsObjectValid(oOrc1)&&!GetIsObjectValid(oOrc2))
   // return TRUE;
   // return FALSE;

    object oPC = GetPCSpeaker();
    object oOrc1 = GetNearestObjectByTag("db_droppofforc",oPC);
    object oOrc2 = GetNearestObjectByTag("db_orcarcher",oPC);
    object oObj = GetFirstObjectInArea(GetArea(oPC));
    while (GetIsObjectValid(oObj))
          {
          if (GetObjectType(oObj) == OBJECT_TYPE_CREATURE &&
              (GetTag(oObj) == "db_droppofforc" ||
               GetTag(oObj) == "db_orcarcher"))
                return FALSE;
          oObj = GetNextObjectInArea(GetArea(oPC));
          }
    return TRUE;
}
