#include "nw_i0_plot"

#include "rb_include"

void main()
{
    switch(GetUserDefinedEventNumber())
    {
        case 5202:
             if(GetNearestPerceivedEnemy(OBJECT_SELF) != OBJECT_INVALID)
             {
                ChangeToWerewolf(OBJECT_SELF, GetNearestPerceivedEnemy());
             }
        break;
    }
}
