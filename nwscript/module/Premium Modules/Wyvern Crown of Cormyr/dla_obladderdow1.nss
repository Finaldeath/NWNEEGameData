//August 2005
// B W-Husey
// Use the ladder (i.e. climb down)

void main()
{
  object oPC = GetLastUsedBy();
  object oTarget = GetNearestObjectByTag("JP_LadderDown");
  AssignCommand(oPC,JumpToObject(oTarget));

object oAssociate1 = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC);
object oAssociate2 = GetAssociate(ASSOCIATE_TYPE_DOMINATED, oPC);
object oAssociate3 = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oPC);
object oAssociate4 = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC);
object oAssociate5 = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC,1);
object oAssociate6 = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC,2);
object oAssociate7 = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC,3);
object oAssociate8 = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC,4);
AssignCommand(oAssociate1, JumpToObject(oTarget));
AssignCommand(oAssociate2, JumpToObject(oTarget));
AssignCommand(oAssociate3, JumpToObject(oTarget));
AssignCommand(oAssociate4, JumpToObject(oTarget));
AssignCommand(oAssociate5, JumpToObject(oTarget));
AssignCommand(oAssociate6, JumpToObject(oTarget));
AssignCommand(oAssociate7, JumpToObject(oTarget));
AssignCommand(oAssociate8, JumpToObject(oTarget));
}
