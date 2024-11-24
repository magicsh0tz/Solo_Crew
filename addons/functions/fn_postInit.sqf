/*
 * Author: magicsh0tz
 */

#include "script_component.hpp"

if (isServer) then {
    localNamespace setVariable [QVAR(handles),nil];
    localNamespace setVariable [QVAR(agentsToDelete),nil];
    
    if (HAS_CBA) then {
        [FUNC(serverPFH),1,[]] call CBA_fnc_addPerFrameHandler;
    } else {
        addMissionEventHandler ["EachFrame",{
            [_thisArgs,_thisEventHandler] call FUNC(serverPFH);
        },[]];
    };
};

if (hasInterface) then {
    [] call FUNC(addActions);
    player addEventHandler ["Respawn",{[] call FUNC(addActions);}];
    
    if (HAS_CBA) then {
        [FUNC(clientPFH),0.1,[]] call CBA_fnc_addPerFrameHandler;
    } else {
        addMissionEventHandler ["EachFrame",{
            [_thisArgs,_thisEventHandler] call FUNC(clientPFH);
        },[]];
    };
};
