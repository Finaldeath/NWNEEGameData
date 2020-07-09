// August 2005
// B W-Husey
// This object can be sat on (Place in OnUsed event)

void main()
{
  object oChair = OBJECT_SELF;
  if(!GetIsObjectValid(GetSittingCreature(oChair)))
  {
    AssignCommand(GetLastUsedBy(), ActionSit(oChair));
  }
}
