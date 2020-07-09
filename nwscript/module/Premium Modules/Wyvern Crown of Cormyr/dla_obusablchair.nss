// B W-Husey
// This script allows object to be sat on.

void main()
{
  object oChair = OBJECT_SELF;
  if(!GetIsObjectValid(GetSittingCreature(oChair)))
  {
    AssignCommand(GetLastUsedBy(), ActionSit(oChair));
  }
}

