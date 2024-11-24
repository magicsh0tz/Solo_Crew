/*
 * Author: magicsh0tz
 * PFH to sync effectiveCommander.
 *
 * Arguments:
 * 0: Arguments <ANY>
 * 1: Handle <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * None
 */

#include "script_component.hpp"

params ["_args","_pfhHandle"];

private ["_unit","_vehicle"];

_unit = player;
if (isNull _unit || {!(alive _unit)}) exitWith {};

_vehicle = objectParent _unit;
if (isNull _vehicle  || {!(alive _vehicle)}) exitWith {};

_controller = _vehicle getVariable [QVAR(controller),objNull];
if (isNull _controller) exitWith {};
if (!([_controller,_vehicle] call FUNC(isGunnerOrCommander))) exitWith {};

_dummyDriver = _vehicle getVariable [QVAR(dummyDriver),objNull];
if (isNull _dummyDriver) exitWith {};
if (!(isAgent (teamMember _dummyDriver))) exitWith {};

if (local _dummyDriver && {isDamageAllowed _dummyDriver}) then {
    _dummyDriver allowDamage false;
    
    #ifdef DEBUG_MODE
        player globalChat "Set dummyDriver allowDamage to false";
    #endif
};

if ((effectiveCommander _vehicle) != _controller) then {
    _vehicle setEffectiveCommander _controller;
    
    #ifdef DEBUG_MODE
        player globalChat format ["Set effectiveCommander to %1",_controller];
    #endif
};
