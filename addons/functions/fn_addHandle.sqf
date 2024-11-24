/*
 * Author: magicsh0tz
 * Adds handle to PFH.
 *
 * Arguments:
 * 0: unit that will control the vehicle <OBJECT>
 * 1: vehicle to be controlled <OBJECT>
 * 2: dummy driver agent <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_controller,_vehicle,_dummyDriver] call mgc_solo_crew_fnc_addHandle
 */

#include "script_component.hpp"

private ["_handles"];

if (canSuspend) exitWith {
    isNil {
        _this call FUNC(addHandle);
    };
};

_handles = localNamespace getVariable [QVAR(handles),[]];
_handles pushBack [_this,CURRENT_TIME];
localNamespace setVariable [QVAR(handles),_handles];
