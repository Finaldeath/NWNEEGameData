#include "hf_in_henchman"

void main()
{
    int nRest = GetLastRestEventType();
    if (nRest == REST_EVENTTYPE_REST_FINISHED)
    {
        HenchmanRemoveFeat(OBJECT_SELF, FEAT_WILD_SHAPE);
    }
}
